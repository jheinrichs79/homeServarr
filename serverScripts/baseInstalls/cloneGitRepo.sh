#!/bin/bash

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
sudo apt-get install -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_2.025_all.deb
sudo dpkg --install webmin_2.025_all.deb
rm webmin_2.025_all.deb

# Get IP address and display access info
IP=$(hostname -I | cut -d' ' -f1)
echo "Webmin installed successfully!"
echo "Access Webmin at https://$IP:10000"
