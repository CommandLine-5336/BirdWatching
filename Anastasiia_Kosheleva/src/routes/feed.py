import os
from flask import Blueprint, render_template, session, redirect, url_for, request
from models import db, Post
from services.storage import upload_to_seaweed, get_file_url

feed_bp = Blueprint('feed', __name__) 

@feed_bp.route('/')
def show_feed():
    posts = Post.query.order_by(Post.created_at.desc()).all()
    birds_data = []
    for post in posts:
        file_url = get_file_url(post.photo)
        print(f"Generated URL for {post.photo}: {file_url}")

        birds_data.append({
            "name": post.title,
            "desc": post.description,
            "loc": post.location,
            "img": get_file_url(post.photo)
        })

    if not birds_data:
        birds_data = [{"name": "No posts yet", "desc": "Sign in and upload", "loc": "Nowhere", "img": ""}]
    return render_template('feed.html', birds_data=birds_data, username=session.get('username', 'User'))

@feed_bp.route('/upload', methods=['POST'])
def upload():
    if 'user_id' not in session:
        return redirect(url_for('auth.index'))

    file = request.files.get('photo')
    object_key = None
    if file and file.filename != '':
        file.stream.seek(0)
        object_key = upload_to_seaweed(file.stream, file.filename)
        print(f"Uploaded object key: {object_key}")

    new_post = Post(
        title=request.form.get('title'),
        location=request.form.get('location'),
        description=request.form.get('description'),
        photo=object_key,
        user_id=session['user_id']
    )
    db.session.add(new_post)
    db.session.commit()

    return redirect(url_for('feed.show_feed'))

