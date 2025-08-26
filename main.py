from flask import Flask, render_template, render_template_string, send_from_directory
from pathlib import Path

BASE_DIR = Path(_file_).resolve().parent
TEMPLATES_DIR = BASE_DIR / "templates"
ASSETS_DIR = BASE_DIR / "assets"
ICON_DIR = BASE_DIR / "icon"

app = Flask(
    _name_,
    static_folder=str(ASSETS_DIR),   # /assets ke liye
    template_folder=str(TEMPLATES_DIR)
)

# ---- Health check (Render ke liye) ----
@app.get("/healthz")
def healthz():
    return "ok", 200

# ---- Favicon (optional) ----
@app.get("/favicon.ico")
def favicon():
    # agar icon/favico(n).ico ho, to serve kar do; warna 404 ignore
    fav = ICON_DIR / "favicon.ico"
    if fav.exists():
        return send_from_directory(str(ICON_DIR), "favicon.ico")
    return ("", 204)

# ---- Home ----
@app.get("/")
def home():
    index_file = TEMPLATES_DIR / "index.html"
    if index_file.exists():
        # templates/index.html ko render karo
        return render_template("index.html")
    # Fallback minimal page:
    return render_template_string(
        """<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Halal Smart Storck</title>
    <style>
      body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Arial,sans-serif;
           margin:0;display:grid;place-items:center;height:100dvh;background:#0b2d20;color:#fff}
      .card{background:#132d27;border:1px solid #1e4b3f;border-radius:16px;padding:24px;max-width:640px}
      h1{margin:0 0 8px}
      a{color:#89ffda}
      .muted{opacity:.8}
    </style>
  </head>
  <body>
    <div class="card">
      <h1>Halal Smart Storck</h1>
      <p class="muted">Flask server is running on Render ✅</p>
      <p>If you add <code>templates/index.html</code>, it will be served here automatically.</p>
      <p class="muted">Health: <code>/healthz</code></p>
    </div>
  </body>
</html>"""
    )

if _name_ == "_main_":
    # local run: python main.py
    app.run(host="0.0.0.0", port=8000, debug=False)
