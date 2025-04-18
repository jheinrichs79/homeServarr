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
