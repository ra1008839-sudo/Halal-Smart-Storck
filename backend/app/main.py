rom fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
import asyncio, json, random, time

app = FastAPI(title="Halal Smart Stock API")

# CORS: mobile/web sab connect kar sake
app.add_middleware(
    CORSMiddleware,
    allow_origins=[""], allow_methods=[""], allow_headers=["*"]
)

# --- Health
@app.get("/health")
def health():
    return {"ok": True, "ts": int(time.time())}

# --- WS Hub: symbol -> set of websockets
clients = {}

@app.websocket("/ws/ticks")
async def ws_ticks(ws: WebSocket):
    await ws.accept()
    q = ws.scope.get("query_string", b"").decode()
    params = dict(p.split("=") for p in q.split("&") if p)
    sym = (params.get("symbol") or "TCS").upper()
    clients.setdefault(sym, set()).add(ws)
    try:
        while True:
            await asyncio.sleep(30)  # keep-alive
    except WebSocketDisconnect:
        clients[sym].discard(ws)

# --- MOCK FEED (0.5s)  → baad me yahin broker WS jodega
async def mock_feeder():
    price, vol = 3800.0, 100
    while True:
        price += random.uniform(-2, 2)
        vol = max(0, vol + random.randint(-5, 15))
        data = {"s":"TCS","p":round(price,2),"v":vol,"t":int(time.time()*1000)}
        for ws in list(clients.get("TCS", [])):
            try:    await ws.send_text(json.dumps(data))
            except:  clients["TCS"].discard(ws)
        await asyncio.sleep(0.5)

@app.on_event("startup")
async def _startup():
    asyncio.create_task(mock_feeder())
