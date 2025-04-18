#!/bin/bash
#Update Script
apt update -y
apt full-upgrade -y
apt autoremove -y
apt clean -y
apt autoclean -y
#END

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
git clone https://github.com/jheinrichs79/HomeServer.git

if [ $? -eq 0 ]; then
    echo "Repository cloned successfully!"
else
    echo "Failed to clone repository. Please check your internet connection and repository URL."
fi

# Make all files and folders executable in the specified directory
cd ~/git/HomeServer/serverScripts
chmod -R +x .

# Install Docker dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $USER

# Verify installation
docker --version

# Install webmin
echo "Installing webmin..."
sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh; sudo bash setup-repos.sh
sudo apt install -y webmin


# Get IP address and display access info
IP=$(hostname -I | cut -d' ' -f1)
echo "Webmin installed successfully!"
echo "Access Webmin at https://$IP:10000"

# Install Samba and dependencies
echo "Installing Samba..."
sudo apt-get update
sudo apt-get install -y samba samba-common-bin

# Create Samba config backup
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Configure Samba for workgroup
cat << EOF | sudo tee /etc/samba/smb.conf
[global]
workgroup = WORKGROUP
server string = Samba Server
security = user
map to guest = bad user
unix extensions = yes
follow symlinks = yes
wide links = yes
create mask = 0777
directory mask = 0777
force create mode = 0777
force directory mode = 0777

[homes]
comment = Home Directories
browseable = no
read only = no
create mask = 0700
directory mask = 0700

[public]
comment = Public Share
path = /samba/public
browseable = yes
create mask = 0777
directory mask = 0777
read only = no
guest ok = yes
EOF

# Create public share directory
sudo mkdir -p /samba/public
sudo chmod 777 /samba/public

# Restart Samba service
sudo systemctl restart smbd
sudo systemctl restart nmbd

# Add Samba through firewall
sudo ufw allow samba

echo "Samba installation complete!"
echo "Default public share created at /samba/public"


clear

echo "Access Webmin at https://$IP:10000"
echo "Access Network Shares at smb://$IP
