from flask import Flask, render_template, send_from_directory
import os
from pathlib import Path

BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
ASSETS_DIR = BASE_DIR / "assets"
ICON_DIR = BASE_DIR / "icon"

app = Flask(_name_, static_folder=str(ASSETS_DIR), template_folder=str(TEMPLATES_DIR))

@app.route("/")
def home():
    # Agar templates/index.html hai to render karega, warna simple text dega
    index_file = TEMPLATES_DIR / "index.html"
    if index_file.exists():
        return render_template("index.html")
    return "Halal Smart Storck is Live ✓"

@app.route("/assets/<path:filename>")
def assets(filename):
    return send_from_directory(ASSETS_DIR, filename)

@app.route("/icon/<path:filename>")
def icon(filename):
    return send_from_directory(ICON_DIR, filename)

if _name_ == "_main_":
    # Local run ke liye
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=True)
