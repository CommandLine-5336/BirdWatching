"""Application factory and initialization module."""
import os

from dotenv import load_dotenv
from flask import Flask

from models import db
from routes.auth import auth_bp
from routes.feed import feed_bp

load_dotenv()


def create_app():
    """Create, configure and return the Flask application instance."""
    flask_app = Flask(__name__)
    flask_app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "default_dev_key")

    db_user = os.getenv("DB_USER")
    db_password = os.getenv("DB_PASSWORD")
    db_host = os.getenv("DB_HOST")
    db_name = os.getenv("DB_NAME")

    flask_app.config["SQLALCHEMY_DATABASE_URI"] = (
        f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}"
    )
    flask_app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    flask_app.config["UPLOAD_FOLDER"] = os.path.join(
        flask_app.root_path, "static/images"
    )
    os.makedirs(flask_app.config["UPLOAD_FOLDER"], exist_ok=True)

    db.init_app(flask_app)

    flask_app.register_blueprint(auth_bp)
    flask_app.register_blueprint(feed_bp)

    with flask_app.app_context():
        db.create_all()

    return flask_app


app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
