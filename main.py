from flask import Flask, render_template, jsonify, send_from_directory
from pathlib import Path

BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
ASSETS_DIR = BASE_DIR / "assets"
ICON_DIR = BASE_DIR / "icon"

app = Flask(_name_, static_folder=str(ASSETS_DIR), template_folder=str(TEMPLATES_DIR))

@app.route("/")
def home():
    index_file = TEMPLATES_DIR / "index.html"
    if index_file.exists():
        return render_template("index.html")
    return "<h2>Halal Smart Stock backend is live ✅</h2>"

@app.route("/healthz")
def healthz():
    return jsonify({"ok": True}), 200

# (optional) icons/static direct serve
@app.route("/icon/<path:filename>")
def icons(filename):
    return send_from_directory(ICON_DIR, filename)

if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000)
