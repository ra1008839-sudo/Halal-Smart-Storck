from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

def gpt_power_signal(volume):
    if volume > 900000:
        return "BUY", "green"
    elif volume > 500000:
        return "WAIT", "orange"
    else:
        return "AVOID", "red"

@app.route('/get-signal', methods=['POST'])
def get_signal():
    data = request.get_json()
    volume = data.get("volume", 0)
    stock = data.get("stock", "Unknown")

    signal, color = gpt_power_signal(volume)

    response = {
        "stock": stock,
        "volume": volume,
        "signal": signal,
        "color": color,
        "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }

    return jsonify(response)

if __name__== '__main__':
    app.run(host='0.0.0.0', port=5000)
