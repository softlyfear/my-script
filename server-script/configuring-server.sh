#!/bin/bash
###############################################
# Configuring the server to run as a root user
###############################################
# Automatic setup
# source <(curl -s https://raw.githubusercontent.com/softlyfear/my-script/main/server-script/configuring-server.sh)
###############################################

#1 update server
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mStarting to set up\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mUpdate & Upgrade Server\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
sudo apt update && \
sudo apt upgrade -y && \

#2 setting up ssh login & disable password login
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mSetting up ssh login & disable password login\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mEnter your ssh public key\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
IFS= read -r sshkey
echo "${sshkey}" > /root/.ssh/authorized_keys
sudo sed -i 's|^PermitRootLogin .*|PermitRootLogin prohibit-password|' /etc/ssh/sshd_config
sudo sed -i 's/^ChallengeResponseAuthentication\s.*$/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication\s.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PermitEmptyPasswords\s.*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication\s.*$/PubkeyAuthentication yes/' /etc/ssh/sshd_config
echo HostKeyAlgorithms +ssh-rsa >> /etc/ssh/sshd_config
echo PubkeyAcceptedAlgorithms +ssh-rsa >> /etc/ssh/sshd_config
sudo systemctl restart sshd

#3 install fail2Ban
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mInstalling Fail2Ban\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
sudo apt install -y fail2ban && \

#4 install and configure Unf
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mInstalling and configure Unf\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
sudo apt-get install -y ufw && \
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
echo -e "\033[35mInstallation and setup complete\033[97m"
echo -e "\033[35m-----------------------------------------------------------------\033[97m"
