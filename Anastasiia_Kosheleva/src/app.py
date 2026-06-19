from flask import Flask, render_template_string
import os

app = Flask(__name__)

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>BirdTok | Pro UI</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;500;700&display=swap');
        
        html, body { 
            margin: 0; padding: 0; width: 100%; 
            background: #ffffff; font-family: 'Inter', sans-serif; 
            overflow-x: hidden; 
        }
        body { display: flex; justify-content: center; min-height: 100vh; }
        
        #feed { 
            width: 100%; max-width: 500px; 
            display: flex; flex-direction: column; 
            align-items: center; 
            padding: 20px 0 0 0; 
            gap: 24px;
        }

        .post { 
            width: 90%; 
            aspect-ratio: 4/5; 
            max-height: calc(100vh - 180px); 
            border-radius: 24px; 
            overflow: hidden; background: #1a1a1a; position: relative;
            flex-shrink: 0; box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .post-img { width: 100%; height: 100%; object-fit: cover; display: block; }

        .info { 
            position: absolute; bottom: 20px; left: 20px; right: 20px;
            padding: 20px; background: rgba(255, 255, 255, 0.9); 
            backdrop-filter: blur(20px); border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .title { font-size: 1.4rem; font-weight: 700; margin-bottom: 5px; }
        .desc { font-size: 0.9rem; color: #555; }
        .loc { font-size: 0.75rem; color: #007aff; font-weight: 600; margin-top: 10px; display: block; }

        .feed-spacer { 
            height: 140px; 
            width: 100%; 
            flex-shrink: 0; 
        }

        .navbar { 
            position: fixed; bottom: 0; left: 0; right: 0; height: 80px;
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px);
            display: flex; justify-content: center; align-items: center;
            z-index: 1000;
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        
        .add-btn { 
            width: 55px; height: 55px; background: #000; color: #fff; 
            border-radius: 50%; display: flex; justify-content: center; align-items: center; 
            font-size: 28px; cursor: pointer; 
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .add-btn:hover { transform: rotate(90deg); }
    </style>
</head>
<body>

    <div id="feed"></div>

    <div class="navbar"><div class="add-btn">+</div></div>

    <script>
        const birds = [
            {name: "Eurasian Eagle-Owl", desc: "Largest owl species, famous for orange eyes.", loc: "Carpathian Mountains", img: "/static/images/eurasian_eagle_owl.jpg"},
            {name: "Golden Eagle", desc: "Majestic predator with a 2km vision range.", loc: "Alpine Peaks", img: "/static/images/golden_eagle.jpg"},
            {name: "Peregrine Falcon", desc: "The fastest animal on the planet.", loc: "Kyiv Sky", img: "/static/images/peregrine_falcon.jpg"},
            {name: "Common Kingfisher", desc: "A colorful blur over the river surface.", loc: "Lviv River", img: "/static/images/common_kingfisher.jpg"},
            {name: "Atlantic Puffin", desc: "Often called the clown of the sea.", loc: "North Coast", img: "/static/images/atlantic_puffin.jpg"},
            {name: "Great Blue Heron", desc: "Patient hunter in shallow waters.", loc: "Wetlands", img: "/static/images/great_blue_heron.jpg"},
            {name: "Barn Owl", desc: "Silent night hunter with heart-shaped face.", loc: "Farmland", img: "/static/images/barn_owl.jpg"}
        ];

        const feed = document.getElementById('feed');
        
        birds.forEach(bird => {
            const div = document.createElement('div');
            div.className = 'post';
            div.innerHTML = `
                <img class="post-img" src="${bird.img}" alt="${bird.name}" loading="lazy" onerror="this.src='data:image/svg+xml;utf8,<svg xmlns=\\'http://www.w3.org/2000/svg\\' width=\\'100\\' height=\\'100\\'><rect width=\\'100\\' height=\\'100\\' fill=\\'%23e0e0e0\\'/><text x=\\'50%\\' y=\\'50%\\' dominant-baseline=\\'middle\\' text-anchor=\\'middle\\' fill=\\'%23666\\' font-family=\\'sans-serif\\'>Missing Image</text></svg>'">
                <div class="info">
                    <div class="title">${bird.name}</div>
                    <div class="desc">${bird.desc}</div>
                    <span class="loc">${bird.loc}</span>
                </div>
            `;
            feed.appendChild(div);
        });

        const spacer = document.createElement('div');
        spacer.className = 'feed-spacer';
        feed.appendChild(spacer);
    </script>
</body>
</html>
"""

@app.route('/')
def home():
    return render_template_string(HTML_TEMPLATE)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)
