from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'user'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    login = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(250), nullable=False)
    
    posts = db.relationship('Post', backref='author', lazy=True)
    
class Post(db.Model):
    __tablename__ = 'post'
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    title = db.Column(db.String(100))
    location = db.Column(db.String(100))
    photo = db.Column(db.String(250))
    description = db.Column(db.String(250))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='CASCADE'))
    
class Like(db.Model):
    __tablename__ = 'like'
    
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='CASCADE'), primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('post.id', ondelete='CASCADE'), primary_key=True)