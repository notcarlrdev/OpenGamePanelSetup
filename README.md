<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/CarlR0001/OpenGamePanelSetup">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Open Game Panel Setup</h3>

  <p align="center">
    A full guide based on Microsoft Azure Virtual Private Server for setting up OGP panel and agent. Best for hosting SAMP Servers, CS etc.
    <br />
    <a href="https://azure.microsoft.com"><strong>Microsoft Azure Free Student Starter Kit »</strong></a>
    <br />
    <br />
  </p>
</div>

## 👨‍💻 VPS Used
Microsoft Azure Virtual Machine: Standard Ds2_v3 2v cpu 8gb disk. Ubuntu 20.04 Gen 1

# 📂 Installation
For this setup, we will use [@SanjaySRocks](https://github.com/SanjaySRocks) OGP Installer for this guide.

## Update and upgrade your Virtual Machine
```bash
sudo apt-get update
```
```bash
sudo apt-get upgrade
```

## Installing OGP Panel & Agent Installer
* OGP Panel Installer
```bash
curl -O https://raw.githubusercontent.com/CarlR0001/OpenGamePanelSetup/main/install-panel.sh
```

* OGP Agent Installer
```bash
curl -O https://raw.githubusercontent.com/CarlR0001/OpenGamePanelSetup/main/install-agent.sh
```

## Run the OGP Panel Installer
```bash
bash install-panel.sh
```

## Run OGP Agent Installer
```bash
bash install-agent.sh
```

# ❌ Errors
Some users using this script ended with some errors. Here's how to fix it.

## Fix cannot access phpmyadmin
```bash
# fix phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# restart apache
service apache2 restart
```

## Fix samp error querying / cannot see logs
```bash
sudo dpkg --add-architecture i386; sudo apt update; sudo apt install curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux netcat lib32gcc1 lib32stdc++6
```

## Cannot access sudo (because not a root user / administrator)
```bash
sudo -i
```

# Adding Obsidian Theme
* Locate any temporary folder
```bash
cd /etc/tmp
```

* Download obsidian theme
```bash
wget https://github.com/hmrserver/Obsidian/archive/refs/heads/master.zip
```

* Unzip obsidian theme
```bash
unzip master.zip
```

* Locate the theme folder
```bash
cd /Obsidian-master/themes
```

* Transfer the Obsidian theme to the panel themes directory
```bash
cp -R Obsidian /var/www/html/themes
```
* Then go to your panel go to Administration -> Theme settings -> Pick Obsidian.

### Built With

* [PHP](https://nextjs.org/)
* [MySQL](https://nextjs.org/)
* [HTML](https://nextjs.org/)