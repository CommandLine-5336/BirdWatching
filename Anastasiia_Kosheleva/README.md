# BirdTok Web Application

Deploys a multi-node local environment via Vagrant (featuring an Nginx proxy, two Flask backends, and a MariaDB database) to host the BirdTok app. The infrastructure and application services are orchestrated using a `Vagrantfile` and provisioned via dedicated bash scripts (`lb.sh`, `front.sh`, and `back.sh`).