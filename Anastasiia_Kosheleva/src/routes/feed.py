"""Feed routes for displaying bird posts."""

from flask import Blueprint, redirect, render_template, session, url_for

feed_bp = Blueprint("feed", __name__)

birds_data = [
    {
        "name": "Eurasian Eagle-Owl",
        "desc": "Largest owl species.",
        "loc": "Carpathian Mountains",
        "img": "/static/images/eurasian_eagle_owl.jpg",
    },
    {
        "name": "Golden Eagle",
        "desc": "Majestic predator.",
        "loc": "Alpine Peaks",
        "img": "/static/images/golden_eagle.jpg",
    },
]


@feed_bp.route("/feed")
def show_feed():
    """Render the bird sightings feed if the user is authenticated."""
    if "username" not in session:
        return redirect(url_for("auth.index"))
    return render_template(
        "feed.html", birds_data=birds_data, username=session["username"]
    )
