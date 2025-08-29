from flask import Flask, render_template, jsonify
import datetime

app = Flask(_name_)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/signal")
def signal():
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    # Simple GPT Power Indicator logic (demo)
    signal_data = {
        "signal": "BUY",
        "reason": "High trading volume detected",
        "time": now
    }
    return jsonify(signal_data)

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000, debug=True)
