# Infrastructure Configuration

* **Tool:** Vagrant (VirtualBox provider)
* **OS Node Base:** Ubuntu 24.04 LTS (Noble)
* **Architecture:** Multi-node local environment
  * `loadbalancer`: Nginx reverse proxy
  * `web1`: Flask backend instance (Port 5000)
  * `web2`: Flask backend instance (Port 5000)
  * `db`: MariaDB database node (Port 3306)

* **Components:**
  * `Vagrantfile`: Defines CPU/RAM resource allocation, private networks, and link provisioning scripts.
  * `.gitignore`: Prevents indexing of `.vagrant/` state directory and local Python virtual environments.

* **Deployment:**
  * Initial build: `vagrant up`
  * Apply configuration changes: `vagrant provision`