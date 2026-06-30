#!/bin/bash
VAGRANT_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCW/15jZtlw398a637dtvmsx2K9kJOmA3hB6whk9ILfS2on5qJF8rqxGUQjLHRDwmLaVL+dNi8Qzi4aB1p9oug4nROj/0Mcz5mi2nUsZK6WYKfoL2SIdX2j6J+wgVGAjQx41t6c/ekeXO2egzpACTtmxheO1uZCy0iTEbKNGodyO+SO7sxG6LZk8J4pT7HTfrveejeZn09Pu4ZQYGiW9vH3jf0AriFsEwDP0Fb6XXA5PHetU25w7KmZdRD9CZwhgxxyPCtgJ8KWWPCYEOEe0bMAhg5AAzfWtludMF5DNTftFxu7Qr+k43zRFAGLuFW7Mg4DqbNeh/g2PAO+RjjkyEY4kBjNkbtSdEdBb64izQXGROuG4VbfCxkVGj0VyzfsI98Wh/4Ht3ESoxBx04EpvtepdyVzU720/800NzPPmnV+FlyRJI7Pwhaw+3LagjviF6QIWmQ2wJqxgFw0IBqux8tdI0r6HR/uMPO/kzvJvUAGoQA6gntNhQQnJDzMu8FySJqMFY68hqwNscxp9Qy4CLjyJcfDpmdaj7fwe2jr6NyABujBveTQLKVeQG/3gq82Kn23kLna3nnDQb8LN97dpKt5yMypwdjeuPD+jP0zKVi+oAf0yyyotDVpCZ106k64IBzhaS/p/2yGp7Ddro/QBvVvJHjyc7oV14fCsDnbD8P/5w== user@homemachine
"
MAKSYM_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDepwrXsJSGx6ao25m3RKHU6JmhlsXshqN7Gyf8UX1XIBhFXsihqrBv5mKjeH8UGtAeu4sLXKkdnWkE6eHo7GK+q8F5NW4wX4D4fdGN9erRC1N/i20VFDHXkn/s/RBprL9DWSwoV+CTDmM+SNOhKwkGkmA36NbCzPl8tD/AV/eH0BaDnVbntIe7H/H9kWVGMCLPWLllemZsroyG7aoM6Qm0FMjJ9sirWxvRHx5dqN/cgE4LFD+9D+pvwwB2/j/se2ZQP/BpM3XOjMgZBdVQGgsVKc8Pmf7rwWBoCT2zLgjr0x0nG6gFcGdk0rHQLTvmWhDVbkiA5ZgueUf2XSVWRIyvc4rSU4EwHwNHL/flF67tGHt7Fp4MYScRiw3cV+Mru+H9f0cJftam+t7rDW9U4F7MDi2ZWZreCGgR5wh20g5lJO8KOgQFu/mcpfHgB79lbKJYiHB0ENfHq+qOL6kXEO2yZnDwzRH5oO+Vdf+WDgGPeTGABO/aa8Ubr2dIsv0UlEfteUolQQNxz+IdROBhNpEmyfmWJXNMLBAszDa1Kg/m047SAIMIFlYHmiKZKkZKLiC3Ert7s5KD0W1Q9+t8r9QeWRbMCG1+7BagcBfRdXm0WUEs+KwQlWMVio6k3K+QwULTxakyr0YENu+q68q8pOuxmFVWq8/39htFFrO1KgCbEw== klimukhmaksim@gmail.com
"
ANASTASIYA_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeCKrl+lqUxhiLUOsHFX8yhnRHKBg6p463OcRanPvDG your_email@example.com
"
MARTA_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKu/5nety1DQoRHMM734GoAr9LC1vZgfW19qWZQSr33Q martakozak94666@gmail.com
"
BOZHENA_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHuM2vd6WVWufObADt1ny3VQ94W/mPBn378W78W1Cxa bozhenaolijnyk01@gmail.com
"
sudo apt update -y
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config.d/50-cloud-init.conf
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl reload ssh
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.71.2
echo $VAGRANT_KEY >> /home/$(hostname)/.ssh/authorized_keys
echo $MAKSYM_KEY >> /home/$(hostname)/.ssh/authorized_keys
echo $ANASTASIYA_KEY >> /home/$(hostname)/.ssh/authorized_keys
echo $MARTA_KEY >> /home/$(hostname)/.ssh/authorized_keys
echo $BOZHENA_KEY >> /home/$(hostname)/.ssh/authorized_keys
sudo chmod 600 /home/$(hostname)/.ssh/authorized_keys
echo $VAGRANT_KEY >> /home/$(hostname)/.ssh/vagrant_key.pub
sudo chmod 644 /home/$(hostname)/.ssh/vagrant_key.pub
echo $MAKSYM_KEY >> /home/$(hostname)/.ssh/maksym.pub
sudo chmod 644 /home/$(hostname)/.ssh/maksym.pub
echo $ANASTASIYA_KEY >> /home/$(hostname)/.ssh/anastasiya.pub
sudo chmod 644 /home/$(hostname)/.ssh/anastasiya.pub
echo $MARTA_KEY >> /home/$(hostname)/.ssh/marta.pub
sudo chmod 644 /home/$(hostname)/.ssh/marta.pub
echo $BOZHENA_KEY >> /home/$(hostname)/.ssh/bozhena.pub
sudo chmod 644 /home/$(hostname)/.ssh/bozhena.pub
(crontab -l ; echo "* */1 * * * trivy fs . &> /home/\$(hostname)/security_scan_\$(hostname)_\$(date +\%Y-\%m-\%d_\%H:\%M).txt") | crontab -
