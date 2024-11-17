#!/bin/bash
###############################################
# Configuring the server to run as a root user
###############################################
# Automatic setup
# source <(curl -s https://raw.githubusercontent.com/softlyfear/my-script/refs/heads/main/server-scripts/configuring-server.sh)
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
# Read the SSH public key from the user input
IFS= read -r sshkey

# Check if the .ssh directory exists, create it if it doesn't
if [ ! -d /root/.ssh ]; then
  mkdir -p /root/.ssh
  echo -e "\033[32mCreated directory /root/.ssh\033[97m"
fi

# Check if the authorized_keys file exists, create it if it doesn't
if [ ! -f /root/.ssh/authorized_keys ]; then
  touch /root/.ssh/authorized_keys
  echo -e "\033[32mCreated file /root/.ssh/authorized_keys\033[97m"
fi

# Append the SSH key to the authorized_keys file
echo "${sshkey}" >> /root/.ssh/authorized_keys
echo -e "\033[32mAdded SSH key to /root/.ssh/authorized_keys\033[97m"

# Set the appropriate permissions for the .ssh directory and authorized_keys file
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
echo -e "\033[32mSet permissions for /root/.ssh and /root/.ssh/authorized_keys\033[97m"

# Optionally, you might want to disable password login by editing the sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo -e "\033[32mDisabled password login in /etc/ssh/sshd_config\033[97m"

# Restart the SSH service to apply changes
systemctl restart sshd
echo -e "\033[32mRestarted SSH service\033[97m"


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
