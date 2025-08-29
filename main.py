from flask import Flask, render_template

app = Flask(_name_)

@app.route("/")
def home():
    return "<h1>Halal Smart Stock is Live 🚀</h1><p>App deployed successfully!</p>"

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000)
