from flask import Flask, render_template, render_template_string, send_from_directory, jsonify
from flask_cors import CORS
from pathlib import Path
import os

# -------- Paths --------
BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
ASSETS_DIR = BASE_DIR / "assets"
ICON_DIR = BASE_DIR / "icon"

# -------- App --------
app = Flask(
    _name_,
    static_folder=str(ASSETS_DIR),       # /assets ke liye
    template_folder=str(TEMPLATES_DIR)   # /templates ke liye
)
CORS(app)

# -------- Routes --------
@app.route("/")
def home():
    """
    templates/index.html ho to wahi render hoga,
    warna lightweight fallback page dikhega (taaki kabhi blank na aaye).
    """
    index_file = TEMPLATES_DIR / "index.html"
    if index_file.exists():
        return render_template("index.html")
    # Fallback HTML
    return render_template_string("""
    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width,initial-scale=1" />
      <title>Halal Smart Stock</title>
      <style>
        body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
             margin:0;display:grid;place-items:center;height:100vh;background:#0b2d39;color:#fff}
        .card{background:#102f3a;border:1px solid #214; padding:28px 32px; border-radius:14px; box-shadow:0 6px 30px rgba(0,0,0,.3)}
        h1{margin:0 0 8px;font-size:24px}
        p{margin:0 0 12px;opacity:.9}
        a{color:#50e3c2;text-decoration:none}
      </style>
    </head>
    <body>
      <div class="card">
        <h1>Halal Smart Stock</h1>
        <p>Template missing; fallback page loaded.</p>
        <p><a href="/healthz">/healthz</a> • <a href="/api/ping">/api/ping</a></p>
      </div>
      <script>
        if ('serviceWorker' in navigator) {
          window.addEventListener('load', () => {
            navigator.serviceWorker.register('/service-worker.js').catch(()=>{});
          });
        }
      </script>
    </body>
    </html>
    """), 200

@app.route("/service-worker.js")
def service_worker():
    """
    Agar aapki project root me service-worker.js hai,
    to Render/Gunicorn par bhi ye route se serve ho jayega.
    """
    return send_from_directory(str(BASE_DIR), "service-worker.js", mimetype="application/javascript")

@app.route("/healthz")
def healthz():
    return jsonify({"status": "ok", "message": "halal smart stock backend is live"}), 200

@app.route("/api/ping")
def ping():
    return jsonify({"pong": True, "version": "v1.0.0", "mode": "prod"}), 200

# Optional: static icons agar directly chahiye
@app.route("/icon/<path:filename>")
def icons(filename):
    return send_from_directory(str(ICON_DIR), filename)

@app.route("/assets/<path:filename>")
def assets(filename):
    return send_from_directory(str(ASSETS_DIR), filename)

if _name_ == "_main_":
    # Local run ke liye
    port = int(os.environ.get("PORT", "8000"))
    app.run(host="0.0.0.0", port=port, debug=False)
