from flask import Flask, render_template_string, request, session, redirect, url_for
from werkzeug.utils import secure_filename
import os
import uuid
import socket

app = Flask(__name__)
app.secret_key = 'super_secret_bird_key'

UPLOAD_FOLDER = 'static/images'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

birds_data = [
    {"id": "1", "name": "Eurasian Eagle-Owl", "desc": "Largest owl species, famous for orange eyes.", "loc": "Carpathian Mountains", "img": "/static/images/eurasian_eagle_owl.jpg"},
    {"id": "2", "name": "Golden Eagle", "desc": "Majestic predator with a 2km vision range.", "loc": "Alpine Peaks", "img": "/static/images/golden_eagle.jpg"},
    {"id": "3", "name": "Peregrine Falcon", "desc": "The fastest animal on the planet.", "loc": "Kyiv Sky", "img": "/static/images/peregrine_falcon.jpg"},
    {"id": "4", "name": "Common Kingfisher", "desc": "A colorful blur over the river surface.", "loc": "Lviv River", "img": "/static/images/common_kingfisher.jpg"},
    {"id": "5", "name": "Atlantic Puffin", "desc": "Often called the clown of the sea.", "loc": "North Coast", "img": "/static/images/atlantic_puffin.jpg"},
    {"id": "6", "name": "Great Blue Heron", "desc": "Patient hunter in shallow waters.", "loc": "Wetlands", "img": "/static/images/great_blue_heron.jpg"},
    {"id": "7", "name": "Barn Owl", "desc": "Silent night hunter with heart-shaped face.", "loc": "Farmland", "img": "/static/images/barn_owl.jpg"}
]

server_name = socket.gethostname()

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>BirdTok | Pro UI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap');
        html, body { margin: 0; padding: 0; width: 100%; background: #ffffff; font-family: 'Inter', sans-serif; overflow-x: hidden; }
        body { display: flex; justify-content: center; min-height: 100vh; }
        #feed { width: 100%; max-width: 500px; display: flex; flex-direction: column; align-items: center; padding: 20px 0 0 0; gap: 24px; }
        .server-badge { background: #000; color: white; padding: 5px 15px; border-radius: 20px; font-size: 0.8rem; margin-bottom: 10px; }
        .post { width: 90%; aspect-ratio: 4/5; border-radius: 24px; overflow: hidden; background: #1a1a1a; position: relative; flex-shrink: 0; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .post-img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .info { position: absolute; bottom: 20px; left: 20px; right: 20px; padding: 20px; background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(20px); border-radius: 20px; }
        .title { font-size: 1.4rem; font-weight: 700; margin-bottom: 5px; }
        .desc { font-size: 0.9rem; color: #555; }
        .loc { font-size: 0.75rem; color: #007aff; font-weight: 600; margin-top: 10px; display: block; }
        .navbar { position: fixed; bottom: 0; height: 80px; width: 100%; max-width: 500px; background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); display: flex; justify-content: center; align-items: center; border-top: 1px solid rgba(0,0,0,0.05); z-index: 1000; }
        .add-btn { width: 55px; height: 55px; background: #000; color: #fff; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; }
    </style>
</head>
<body>
    <div id="feed">
        <div class="server-badge">Connected to: {{ server_name }}</div>
    </div>
    <div class="navbar">
        {% if session.get('logged_in') %}
            <div class="add-btn" data-bs-toggle="modal" data-bs-target="#uploadModal">+</div>
            <a href="/logout" class="ms-3 text-dark">Logout</a>
        {% else %}
            <div class="add-btn" data-bs-toggle="modal" data-bs-target="#loginModal">+</div>
        {% endif %}
    </div>

    <div class="modal fade" id="loginModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered"><div class="modal-content"><div class="modal-body">
        <form action="/login" method="POST">
            <div class="mb-3"><input type="text" name="username" class="form-control" placeholder="Username" required></div>
            <div class="mb-3"><input type="password" name="password" class="form-control" placeholder="Password" required></div>
            <button type="submit" class="btn btn-dark w-100">Sign In</button>
        </form>
      </div></div></div>
    </div>

    <div class="modal fade" id="uploadModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered"><div class="modal-content"><div class="modal-body">
        <form action="/upload" method="POST" enctype="multipart/form-data">
            <input type="file" name="photo" class="form-control mb-3" required>
            <input type="text" name="title" class="form-control mb-3" placeholder="Bird Name" required>
            <input type="text" name="location" class="form-control mb-3" placeholder="Location" required>
            <textarea name="description" class="form-control mb-3" placeholder="Description..."></textarea>
            <button type="submit" class="btn btn-dark w-100">Publish</button>
        </form>
      </div></div></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
const allBirds = {{ birds_data | tojson | safe }};
const feed = document.getElementById('feed');

allBirds.forEach(bird => {
    const div = document.createElement('div');
    div.className = 'post';
    div.innerHTML = `
        <img class="post-img" src="${bird.img}" alt="${bird.name}">
        <div class="info">
            <div class="title">${bird.name}</div>
            <div class="desc">${bird.desc}</div>
            <span class="loc">${bird.loc}</span>
        </div>
    `;
    feed.appendChild(div);
});
    </script>
</body>
</html>
"""

@app.route('/')
def home():
    return render_template_string(HTML_TEMPLATE, birds_data=birds_data, server_name=server_name)

@app.route('/login', methods=['POST'])
def login():
    if request.form.get('username') == 'admin' and request.form.get('password') == 'admin':
        session['logged_in'] = True
    return redirect(url_for('home'))

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    return redirect(url_for('home'))

@app.route('/upload', methods=['POST'])
def upload():
    if not session.get('logged_in'): return redirect(url_for('home'))
    file = request.files.get('photo')
    if file:
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        birds_data.insert(0, {"id": str(uuid.uuid4()), "name": request.form.get('title'), "desc": request.form.get('description'), "loc": request.form.get('location'), "img": f"/static/images/{filename}"})
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)