from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Halal Smart Stock is Live 🚀</h1><p>App deployed successfully!</p>"

if __name__ == "_main_":
    app.run(host="0.0.0.0", port=5000)
