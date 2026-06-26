#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install wget apt-transport-https gnupg lsb-release -y

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null

apt-get update -y
apt-get install trivy -y
trivy fs / > /var/log/trivy-report.txt