#!/bin/bash
set -e

if [ -f "/vagrant/id_rsa.pub" ]; then
    mkdir -p /home/vagrant/.ssh
    
    if ! grep -qF "$(cat /vagrant/id_rsa.pub)" /home/vagrant/.ssh/authorized_keys 2>/dev/null; then
        cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    fi
    
    chown -R vagrant:vagrant /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    chmod 600 /home/vagrant/.ssh/authorized_keys
fi

if ! grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "Configuring SSH..."

    if [ -f /etc/ssh/sshd_config.d/50-cloud-init.conf ]; then
        sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config.d/50-cloud-init.conf
    fi

    sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
    sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

    systemctl restart ssh
else
    echo "SSH settings are already applied. Skipping..."
fi