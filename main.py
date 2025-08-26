from flask import Flask, render_template, send_from_directory
from pathlib import Path

# ==== Paths ====
BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
STATIC_DIRS = {
    "assets": BASE_DIR / "assets",
    "icon": BASE_DIR / "icon",
    "market app": BASE_DIR / "market app",
}

# ==== Flask app ====
app = Flask(
    _name_,
    template_folder=str(TEMPLATES_DIR),
    static_folder=None  # static ko hum manual routes se serve kar rahe hain
)

# ---- Home page ----
@app.route("/")
def home():
    # templates/index.html render hoga
    return render_template("index.html")

# ---- Health check (Render settings me use karo) ----
@app.route("/healthz")
def healthz():
    return "ok", 200

# ---- Static folders serve karne ke simple routes ----
@app.route("/assets/<path:filename>")
def serve_assets(filename):
    return send_from_directory(STATIC_DIRS["assets"], filename)

@app.route("/icon/<path:filename>")
def serve_icon(filename):
    return send_from_directory(STATIC_DIRS["icon"], filename)

@app.route("/market%20app/<path:filename>")
@app.route("/market app/<path:filename>")
def serve_market_app(filename):
    return send_from_directory(STATIC_DIRS["market app"], filename)

# local run ke liye (Render par gunicorn chalega)
if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000)
