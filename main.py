from flask import Flask, render_template, request, jsonify
from datetime import datetime
import os

app = Flask(__name__, template_folder="templates", static_folder="static")

# -------- Home + Health ----------
@app.route("/")
def home():
    # templates/index.html render karega
    return render_template("index.html")

@app.route("/health")
def health():
    return "ok", 200

# -------- Simple Signal API (demo) ----------
def gpt_power_signal(volume: int):
    if volume > 900_000:
        return "BUY", "green"
    elif volume > 500_000:
        return "WAIT", "orange"
    else:
        return "AVOID", "red"

@app.route("/get-signal", methods=["POST"])
def get_signal():
    data = request.get_json(silent=True) or {}
    volume = int(data.get("volume", 0))
    stock  = str(data.get("stock", "Unknown"))
    signal, color = gpt_power_signal(volume)
    return jsonify({
        "stock": stock,
        "volume": volume,
        "signal": signal,
        "color": color,
        "timestamp": datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC")
    })

# -------- Run (Render/Heroku style) ----------
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port)
