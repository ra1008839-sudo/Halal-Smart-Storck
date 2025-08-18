from flask import Flask, jsonify, send_from_directory, render_template, render_template_string
import os
from pathlib import Path

# Folders (optional): templates/ for index.html, assets/ for images/css/js, icon/ for favicon
BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
ASSETS_DIR = BASE_DIR / "assets"
ICON_DIR = BASE_DIR / "icon"

app = Flask(_name_, static_folder=str(ASSETS_DIR), template_folder=str(TEMPLATES_DIR))


@app.route("/")
def home():
    """
    If templates/index.html exists -> render it.
    Otherwise show a minimal built-in page so the app always works.
    """
    index_file = TEMPLATES_DIR / "index.html"
    if index_file.exists():
        return render_template("index.html", app_name="Halal Smart Stock")
    # Fallback inline page (no templates needed)
    return render_template_string(
        """
        <!doctype html>
        <html lang="en">
        <head>
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <title>Halal Smart Stock</title>
          <style>
            body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,sans-serif;margin:0;padding:40px;line-height:1.5}
            .wrap{max-width:880px;margin:0 auto}
            .badge{display:inline-block;background:#10b981;color:#fff;border-radius:9999px;padding:6px 10px;font-size:12px}
            .card{border:1px solid #e5e7eb;border-radius:12px;padding:20px;margin-top:18px}
            code{background:#f3f4f6;padding:2px 6px;border-radius:6px}
          </style>
        </head>
        <body>
          <div class="wrap">
            <span class="badge">Backend Live</span>
            <h1>Halal Smart Stock – Backend</h1>
            <p>This service is running on Flask + Gunicorn.</p>

            <div class="card">
              <h3>Health</h3>
              <p>Check health at <code>/healthz</code></p>
              <p>Version API: <code>/api/version</code></p>
            </div>

            <div class="card">
              <h3>Static files</h3>
              <p>Place files in <code>assets/</code> and access them at <code>/assets/&lt;file&gt;</code>.</p>
            </div>
          </div>
        </body>
        </html>
        """
    )


@app.route("/healthz")
def health():
    """Used by Render health checks."""
    return "ok", 200


@app.route("/api/version")
def version():
    return jsonify({"name": "halal-smart-stock-backend", "version": "1.0.0", "mode": "live"})


@app.route("/favicon.ico")
def favicon():
    # Serve icon/favicon.ico if present, else 204
    fav = ICON_DIR / "favicon.ico"
    if fav.exists():
        return send_from_directory(str(ICON_DIR), "favicon.ico")
    return ("", 204)


@app.route("/assets/<path:filename>")
def assets(filename: str):
    """Serve static assets (images, css, js) from assets/ directory."""
    return send_from_directory(str(ASSETS_DIR), filename)


if _name_ == "_main_":
    # Local run (Render will use gunicorn from Procfile)
    port = int(os.getenv("PORT", "8000"))
    app.run(host="0.0.0.0", port=port, debug=True)
