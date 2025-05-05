Please see my Substack on how to use the scripts on my git repo.
* https://jaredheinrichs.substack.com/

![alt text](https://substackcdn.com/image/fetch/w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1b50455a-56e8-4e2c-8430-7eec6b9ab7e5_512x512.png)

# The homeServarr Setup

This repo came about because several of my friends wanted the same setup I have in my house.
Unfortunately, there are many manual steps to set it up. After several setups, I began to dread each time I was asked if I could help out.
Although my setup technically utilized Docker under the hood, it was implemented poorly.
Now that I am more proficient with Linux, Docker, and Docker Compose, it is time to automate most of the setup and host it on GitHub.

These scripts are designed to make setting up a home server easy.
A few people have asked if I can add the program "x" to the list of scripts/compose files.
I am currently not interested in adding software to this setup outside of the software I would typically use in a deployment.

## Requirements:
Server OS
* The latest version of Ubuntu Server

## File Layout

The layout of the repository will look like this:
[Mermaid Flowchart](https://mermaid.live/edit#pako:eNptlE1vozAQhv-K5ZO3Sos_ICGoqrRKpL10L5vDSlUuDp4AW8DImLTZKv99zWdkaUEyPK_fGRjj4QunWgFO8LnUH2kujUWvv441cgelJMh1Bd8mZCToWjC1rOD5ZFDwMo4Pf6QB9TC7OAmUTt_BeJ79IKGdrs9Fhs66VGDah2lyZ0BaUOh0RWMoSnXV6BaWpKJP-lGXWqrWy_s7BwNINk2LZsMSFJIgK6xnP1zr1D3oo7A5-uGG7rS4IxJUoAr5HJzMbH-VJgO0N8UFUKW72o51jhFsWp4DmIs0ZsrD2Fz_bqxh1t26uMW7gDmkpmhsu-ThlLReCs5Ia2WtpFHfXWGzygl8WiMnaRLFf60hsUZ3pxLaXGtb1NkSICixl8kmGKn0pYA5THDSNtrYhQU5y6oorzOHpOraIp0xIiet3-8vQyl6fHxx-2TeLyNyH4WPoY_RkiwcBEbnxR6R-ciXjzHGc-oj8_Fu56MgfAyXp0eDIKiPzEfuo_Ax9HGo7H72U_drP-IVrsBUslCuG7967YhtDhUcceJuFZxlV9ojPtY3Z5Wd1f1uxok1Hayw-95ZjpOzLFtHXaNcR-0LmRlZzZZG1jj5wp84EVv6RPk23qzj7SYKWRiu8BUncfzEYrbmoYjXfLPd3lb4r9Yunj7FfBtxQeN1FG7iiK2HbG_D5JjctY7V5uf4Lxl-KSucmb6W6f2gVn1PuCbCSXT7B2C_Pps)
![alt text](https://substackcdn.com/image/fetch/w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F14ed6356-7858-4f9b-85b6-6a27e106c6b5_918x823.png)

## Automation File Types
For my setup, I will be hosting a multitude of items to make setting up a home server:
* Server Scripts (Shell scripts)
  - sh. scripts to install base server software (See Server scripts)
  - sh. Scripts to clean up Docker
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
* Portainer
* PiHole
* SpeedTest Tracker
* Open Speed Test
* Code-Server
* Homarr

### Extra Home Server Apps
* Cloudflare tunnel
* MonkeyType

### Servarr
This Docker Compose stack will easily install all these pieces of software.
* gluetun
* Prowlar
* Sonarr
* Radarr
* Lidarr
* Readarr
* qbittorrent
* Plex
* Jellyfin
* JDownloader-2



