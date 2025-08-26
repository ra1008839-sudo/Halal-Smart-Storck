from flask import Flask, render_template, send_from_directory

app = Flask(_name_, static_folder="assets", template_folder="templates")

# ✅ Home Page
@app.route("/")
def home():
    return render_template("index.html")

# ✅ Static files auto serve honge (assets, css, js, images)
@app.route("/assets/<path:filename>")
def custom_static(filename):
    return send_from_directory("assets", filename)

# ✅ Icons serve
@app.route("/icon/<path:filename>")
def icons(filename):
    return send_from_directory("icon", filename)

# ✅ Market App static serve
@app.route("/marketapp/<path:filename>")
def marketapp(filename):
    return send_from_directory("market app", filename)

# ✅ Health check (Render ke liye zaruri hai)
@app.route("/health")
def health():
    return "OK", 200

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000)
