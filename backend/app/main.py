from fastapi import FastAPI
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
import time, random

app = FastAPI()

# CORS setup
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
def health():
    return {"ok": True, "time": time.time()}

# Example mock stock signal
@app.get("/signal")
def get_signal(stock: str, volume: int):
    score = random.randint(0, 100)
    status = "BUY" if score > 60 else "WAIT"
    return {"stock": stock, "volume": volume, "score": score, "status": status}
