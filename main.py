from flask import Flask, render_template, request, redirect, url_for, session, jsonify
from functools import wraps
import os, datetime, random

app = Flask(__name__, static_folder="static", template_folder="templates")

# SECRET KEY (set env var in Replit -> Secrets as SECRET_KEY; otherwise fallback)
app.secret_key = os.getenv("SECRET_KEY", "change-me-in-prod")

# ------- Dummy users (replace with DB/Firebase later) -------
USERS = {
    "admin@example.com": {
        "password": "admin123",   # <- change this
        "name": "Admin"
    }
}

# ------- Login required decorator -------
def login_required(view):
    @wraps(view)
    def wrapped(*args, **kwargs):
        if not session.get("user"):
            return redirect(url_for("login", next=request.path))
        return view(*args, **kwargs)
    return wrapped

# ------- Routes -------
@app.route("/")
@login_required
def home():
    user = session["user"]
    return render_template("index.html", user=user)

@app.route("/signal")
@login_required
def get_signal():
    signals = ["BUY ✅", "WAIT ⏳", "AVOID ❌"]
    signal = random.choice(signals)
    now = datetime.datetime.now().strftime("%H:%M:%S")
    return jsonify({"signal": signal, "time": now})

@app.route("/login", methods=["GET", "POST"])
def login():
    # already logged in?
    if session.get("user"):
        return redirect(url_for("home"))

    error = None
    if request.method == "POST":
        email = request.form.get("email", "").strip().lower()
        password = request.form.get("password", "")
        user = USERS.get(email)

        if not user or user["password"] != password:
            error = "Invalid email or password"
        else:
            session["user"] = {"email": email, "name": user.get("name", email)}
            next_url = request.args.get("next") or url_for("home")
            return redirect(next_url)

    return render_template("login.html", error=error)

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))

# health check (optional for uptime monitors)
@app.route("/healthz")
def healthz():
    return "ok", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
