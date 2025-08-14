# TOP par (baaki imports ke saath) yeh add karo:
from fastapi.responses import HTMLResponse

# ...file ka existing code yahi rahe (health, ws, mock_feeder, startup)...

# --- Simple Home Page (live ticks viewer)
@app.get("/", response_class=HTMLResponse)
def index():
    return """
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Halal Smart Stock • Live Ticks</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Arial;sans-serif;margin:0;background:#0b3d2e;color:#fff}
    .wrap{max-width:720px;margin:28px auto;padding:16px}
    .card{background:#08261d;border-radius:14px;padding:18px;box-shadow:0 6px 18px rgba(0,0,0,.25)}
    h1{font-size:22px;margin:0 0 12px;color:#d4af37}
    .row{display:flex;gap:12px;align-items:center}
    .sym{font-weight:700;font-size:18px}
    .price{font-size:40px;font-weight:800;margin:6px 0}
    .vol{color:#d4af37}
    .flashUp{background:rgba(0,160,0,.18)}
    .flashDown{background:rgba(200,0,0,.18)}
    input{padding:10px;border-radius:10px;border:none;outline:none}
    button{padding:10px 14px;border-radius:10px;border:none;background:#d4af37;color:#08261d;font-weight:700}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="card" id="card">
      <h1>Halal Smart Stock — Live</h1>
      <div class="row">
        <input id="symbol" value="TCS" style="flex:1">
        <button onclick="connect()">Connect</button>
      </div>
      <div class="sym" id="sym">TCS</div>
      <div class="price" id="price">--</div>
      <div class="vol" id="vol">Vol: --</div>
    </div>
  </div>
<script>
let ws, last=0;
function connect(){
  const s = document.getElementById('symbol').value.toUpperCase();
  document.getElementById('sym').textContent = s;
  if(ws) ws.close();
  // same host ke WS URL banalo:
  const wsUrl = (location.origin.replace('http','ws') + '/ws/ticks?symbol=' + encodeURIComponent(s));
  ws = new WebSocket(wsUrl);
  ws.onmessage = (e)=>{
    const m = JSON.parse(e.data);
    const p = m.p, v=m.v;
    const card = document.getElementById('card');
    card.classList.remove('flashUp','flashDown');
    if (last && p>last) card.classList.add('flashUp');
    if (last && p<last) card.classList.add('flashDown');
    last = p;
    document.getElementById('price').textContent = p.toFixed(2);
    document.getElementById('vol').textContent = 'Vol: ' + v;
  };
}
connect();
</script>
</body>
</html>
"""
