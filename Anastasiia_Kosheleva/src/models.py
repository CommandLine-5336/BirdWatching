"""Database models module."""

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class User(db.Model):
    """User account model."""

    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    login = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(250), nullable=False)

    posts = db.relationship("Post", backref="author", lazy=True)


class Post(db.Model):
    """Post submission model."""

    __tablename__ = "post"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    photo = db.Column(db.String(100))
    description = db.Column(db.String(100))
    user_id = db.Column(db.Integer, db.ForeignKey("user.id", ondelete="CASCADE"))


class Like(db.Model):
    __tablename__ = "like"
    """Like interaction model."""
    user_id = db.Column(
        db.Integer, db.ForeignKey("user.id", ondelete="CASCADE"), primary_key=True
    )
    post_id = db.Column(
        db.Integer, db.ForeignKey("post.id", ondelete="CASCADE"), primary_key=True
    )
