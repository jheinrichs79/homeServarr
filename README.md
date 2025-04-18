Please see my Substack on how to use the scripts on my git repo.
* https://jaredheinrichs.substack.com/

![alt text](https://substackcdn.com/image/fetch/w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1b50455a-56e8-4e2c-8430-7eec6b9ab7e5_512x512.png)

# The homeServarr Setup

This repo came about because several of my friends wanted the same setup I have in my house.
Unfortunately, there are many manual steps to set it up. After several setups, I started dreading each time I was asked if I could help out.
While my setup technically used Docker under the covers, it was done very poorly.
Now that I am more proficient with Linux, Docker and Docker Compose, I feel it is time to automate most of the setup as well as host it on Github.

These scripts are created in a way that will make setting up a home server easy.
A few people have asked if I can add the program "x" to the list of scripts/compose files.
I am currently NOT interested in adding software to this setup outside of the software I would use in a typical deployment.

## Requirements:
Server OS
* The latest version of Ubuntu Server

## File Layout

The layout of the repository will look like this:

* serverScripts
  - baseInstalls
    - webin
    - docker
    - samba
  - troubleShooting
    - docker
  - scheduledTasks
* dockerCompose
  - standardApps
  - servarr
  - optionalApps

## Automation File Types
For my setup, I will be hosting a multitude of items to make setting up a home server:
* Server Scripts (Shell scripts)
  - sh. scripts to install base server software (See Server scripts)
  - sh. scripts to clean up Docker
  - sh. scripts to edit files downloaded from git to fit your machine dynamically
* Docker Compose Files

## Server Scripts
The shell scripts will allow you to install these pieces of software easily
* Webmin
* Docker
* Samba

## Docker Compose Files

### Standard Home Server Apps
These are the Docker apps that form the base of the Home Server
* PiHole
* AdGuard
* SpeedTest Tracker
* Open Speed Test
* vsCodeServer
* Homarr

### Optional Home Server App
* Cloudflare tunnel
* MonkeyType

### Servarr
This Docker Compose stack will install all these pieces of software with ease.
* gluetun
* Prowlar
* Sonarr
* Radarr
* Lidarr
* Readarr
* qbittorrent
* Plex
* Jellyfin



