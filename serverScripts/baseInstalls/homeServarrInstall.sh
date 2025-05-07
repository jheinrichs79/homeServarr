#!/bin/bash

echo "==================================================="
echo " Welcome to the homeServarr Setup Script
echo " Written by: Jared Heinrichs"
echo " https://github.com/jheinrichs79/homeServarr"
echo "==================================================="

#Ensures the server is setup for the pi-hole install
CONFIG_FILE="/etc/systemd/resolved.conf"
# Ensure the line is uncommented and changed
sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/' "$CONFIG_FILE"

# Restart systemd-resolved to apply the changes
sudo systemctl restart systemd-resolved
sudo service systemd-resolved restart

echo "Updated DNSStubListener setting and restarted systemd-resolved."

# Install git if not already installed
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing git..."
    sudo apt-get update
    sudo apt-get install -y git
fi

# Configure git globally if not already configured
if [ -z "$(git config --global user.name)" ]; then
    echo "Enter your Git username:"
    read git_username
    git config --global user.name "$git_username"
fi

if [ -z "$(git config --global user.email)" ]; then
    echo "Enter your Git email:"
    read git_email
    git config --global user.email "$git_email"
fi

# Make the directory where all git clones will go.
cd ~
mkdir git
cd git

# Clone the repository
echo "Cloning repository..."
git clone https://github.com/jheinrichs79/homeServarr.git

read -n 1 -s -p "Press any key to continue..."

if [ $? -eq 0 ]; then
    echo "Repository cloned successfully!"
else
    echo "Failed to clone repository. Please check your internet connection and repository URL."
fi

# Make all files and folders executable in the specified directory
cd ~/git/homeServarr/serverScripts
sudo chmod -R +x .

# Install Docker dependencies
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
echo "Add Docker's official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo ""
echo ""

# Add Docker repository
echo "Add Docker Repository"
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo ""
echo ""

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $USER

#pause
read -n 1 -s -p "Press any key to continue..."

# Verify installation
docker --version

# Install webmin
echo "Installing webmin..."
sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; sudo bash setup-repos.sh
sudo apt install -y webmin


# Get IP address and display access info
IP=$(hostname -I | cut -d' ' -f1)
echo "Webmin installed successfully!"
echo ""
echo ""

# Install Samba and dependencies
echo "Installing Samba..."
sudo apt-get install -y samba samba-common-bin

#Setup SAMBA USER
echo "Creating SAMBA user: 'homeservarr'"

#Add the Samba User
sudo smbpasswd -a homeservarr

#Enable the User in Samba
sudo smbpasswd -e homeservarr
echo ""
echo "Verifying SAMBA Users created"
sudo pdbedit -L | grep homeservarr
echo ""
echo ""
echo "Restarting SAMBA Service"
sudo systemctl restart smbd nmbd
read -n 1 -s -p "Press any key to continue..."
echo ""
echo ""

# Create Samba config backup
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Configure Samba for workgroup
cat << EOF | sudo tee /etc/samba/smb.conf
# Global Samba Configuration
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   netbios name = homeservarr
   disable netbios = no
   security = user
   map to guest = Bad User
   dns proxy = no

   # Enable file sharing with Windows
   server role = standalone
   hosts allow = 192.168.101.0/24
   load printers = no
   printing = bsd
   disable spoolss = yes

   # Enable SMB versions (compatible with Windows)
   server min protocol = SMB2
   server max protocol = SMB3

   # Allow authentication
   passdb backend = tdbsam
   smb encrypt = required

# Share Configuration
[Shared]
   comment = Shared Files
   path = /home/homeservarr/shared
   browseable = yes
   writable = yes
   guest ok = no
   valid users = homeservarr
   create mask = 0775
   directory mask = 0755
   force user = homeservarr
   force create mode = 0775
   force directory mode = 0775
EOF

# Restart Samba service
sudo systemctl restart smbd
sudo systemctl restart nmbd

echo ""
echo ""
echo "Samba installation complete!"
echo "Default public share created at /samba/public"
echo ""
echo ""

# Disable Firewall
sudo ufw disable
sudo systemctl stop firewalld

echo ""
echo "Access Webmin at https://$IP:10000"
echo "Access Network Shares at smb://$IP"
