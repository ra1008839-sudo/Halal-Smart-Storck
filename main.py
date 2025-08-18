from flask import Flask, render_template, jsonify
from flask_cors import CORS

app = Flask(_name_)
CORS(app)  # जरूरत हो तो WebViewer/वेब से कॉल की अनुमति

# ---------- Pages ----------
@app.route("/")
def home():
    # templates/index.html रेंडर करेगा
    return render_template("index.html", app_name="Halal Smart Stock")

@app.route("/healthz")
def health():
    return "ok", 200

# ---------- Demo APIs (placeholder) ----------
@app.route("/api/ping")
def ping():
    return jsonify({"status": "ok", "message": "Halal Smart Stock backend is live"})

@app.route("/api/version")
def version():
    return jsonify({"version": "v0.1.0", "mode": "demo"})

# लोकल पर ही डेव-सर्वर चले; Render पर Gunicorn चलेगा
if _name_ == "_main_":
    app.run(host="0.0.0.0", port=5000, debug=True)
