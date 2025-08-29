from flask import Flask, render_template, jsonify
import datetime

@app = Flask(_name_, static_folder="assets", template_folder="templates")

@app.route("/")
def home():
    # templates/index.html render hoga; agar nahi hai to simple text bhej do
    try:
        return render_template("index.html")
    except Exception:
        return "Halal Smart Stock running", 200

@app.route("/signal")
def signal():
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    data = {"signal": "BUY", "reason": "Volume spike", "time": now}
    return jsonify(data)

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000, debug=True)
