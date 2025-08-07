from flask import Flask, render_template, request, jsonify
from datetime import datetime
import os

app = Flask(__name__, template_folder="templates", static_folder="static")


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    return "ok", 200


def gpt_power_signal(volume: int):
    if volume > 900000:
        return "BUY", "green"
    elif volume > 500000:
        return "WAIT", "orange"
    else:
        return "AVOID", "red"


@app.route("/get-signal", methods=["POST"])
def get_signal():
    data = request.get_json(silent=True) or {}
    volume = int(data.get("volume", 0))
    stock = str(data.get("stock", "Unknown"))
    signal, color = gpt_power_signal(volume)
    return jsonify(
        {
            "stock": stock,
            "volume": volume,
            "signal": signal,
            "color": color,
            "timestamp": datetime.utcnow().isoformat() + "Z",
        }
    )


@app.errorhandler(404)
def fallback(_):
    # Agar koi aur path aayega to index.html hi de do (SPA style)
    return render_template("index.html"), 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port)
