#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y && apt-get install mariadb-server -y

sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

mysql -u root -e "CREATE DATABASE IF NOT EXISTS birdwatcher;"
mysql -u root -e "GRANT ALL PRIVILEGES ON birdwatcher.* TO 'bird_user'@'%' IDENTIFIED BY '12345';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u bird_user -p12345 birdwatcher -e "
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    location VARCHAR(100),
    image_file VARCHAR(100)
);

TRUNCATE TABLE posts;

INSERT INTO posts (title, description, location, image_file) VALUES
('Eurasian Eagle-Owl', 'Largest owl species, famous for orange eyes.', 'Carpathian Mountains', 'eurasian_eagle_owl.jpg'),
('Golden Eagle', 'Majestic predator with a 2km vision range.', 'Alpine Peaks', 'golden_eagle.jpg'),
('Peregrine Falcon', 'The fastest animal on the planet.', 'Kyiv Sky', 'peregrine_falcon.jpg'),
('Common Kingfisher', 'A colorful blur over the river surface.', 'Lviv River', 'common_kingfisher.jpg'),
('Atlantic Puffin', 'Often called the clown of the sea.', 'North Coast', 'atlantic_puffin.jpg'),
('Great Blue Heron', 'Patient hunter in shallow waters.', 'Wetlands', 'great_blue_heron.jpg'),
('Barn Owl', 'Silent night hunter with heart-shaped face.', 'Farmland', 'barn_owl.jpg');
"
