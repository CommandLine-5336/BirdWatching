import json
import os
import random
import socket

from flask import Flask, render_template

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
JSON_PATH = os.path.join(BASE_DIR, "birds.json")

with open(JSON_PATH, "r", encoding="utf-8") as f:
    data = json.load(f)
    BIRDS = data["birds"]


@app.route("/")
def index():
    hostname = socket.gethostname()
    selected_bird = random.choice(BIRDS)

    return render_template("index.html", hostname=hostname, bird=selected_bird)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
