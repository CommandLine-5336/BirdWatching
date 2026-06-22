# Web Node Configuration

* **File:** "web.sh"
* **Role:** Web server setup for application nodes.
* **Actions:**
  * Installs Nginx.
  * Configures reverse proxy to forward traffic to Flask backend (127.0.0.1:5000).
* **Execution:** "sudo bash web.sh"
