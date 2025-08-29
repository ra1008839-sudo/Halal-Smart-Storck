from flask import Flask, render_template

app = Flask(_name_)

# Home route
@app.route("/")
def home():
    return "<h2>✅ Halal Smart Stock App is Running Successfully!</h2>"

# Example API route (you can expand later)
@app.route("/signal")
def signal():
    # Dummy response, you can add GPT logic later
    return {"status": "OK", "signal": "BUY", "volume": 1200}

if _name_ == "_main_":
    # Debug mode for local run
    app.run(host="0.0.0.0", port=5000, debug=True)
