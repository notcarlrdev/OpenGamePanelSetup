<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/CarlR0001/OpenGamePanelSetup">
    <img src="images/logo.png" alt="Logo">
  </a>

  <h3 align="center">Open Game Panel Setup</h3>

  <p align="center">
    A full guide based on Microsoft Azure Virtual Private Server for setting up OGP panel and agent. Best for hosting SAMP Servers, CS etc.
    <br />
    <a href="https://azure.microsoft.com/en-us/free/students/"><strong>Microsoft Azure Free Student Starter Kit »</strong></a>
    <br />
    <br />
  </p>
</div>

## 👨‍💻 VPS Used
Microsoft Azure Virtual Machine: Standard Ds2_v3 2v cpu 8gb disk. Ubuntu 20.04 Gen 1

# 📂 Installation
For this setup, we will use [@SanjaySRocks](https://github.com/SanjaySRocks) OGP Installer for this guide.

## Edit your Virtual Machine's port ( For Azure Users Only! )
* Go to your Virtual Machine
* Click the Three line navigation button on the left and search for networking
* Add inbound port and add this variables to that inbound

```
Port = 0-63553
Priority = 100
Name = All_ports
```

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

## Bind all ip to mysql (for ubuntu 20.04 only)
```
sed -i "s/^bind-address.*/bind-address=0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"
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

## Fix can't upload files more than 8MB
```bash
# go to php.ini directory
cd /etc/php/7.4/apache2

# edit php.ini
nano php.ini

# Change this variables with your desired file size. 
memory_limit = 512M
post_max_size = 150M
upload_max_filesize = 200M
```

## Fix MySQL Offline
```bash
#open mysql thru ssh
sudo mysql -u root -p

#instead of mariadb, use Mysql
USE mysql;

#update root user plugin
UPDATE user SET plugin='' WHERE User='root';

#flush account privellages
FLUSH PRIVILEGES;

#exit mariadb
EXIT;
```


# Adding Obsidian Theme
* Locate any temporary folder
```bash
cd /tmp
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

# Adding recaptcha for logging in and panel registration
* First go to [https://www.google.com/recaptcha/admin#list](https://www.google.com/recaptcha/admin#list) and create your site & secret key

* go to register module and edit captchakeys.php. replace the keys with yours generated from recaptcha site.
```bash
cd /var/www/html/modules/register
nano captchakeys.php
```

*  Adding scripts to the layout page
```bash
cd /var/www/html/themes/Obsidian
nano layout.html

# then paste this <script src='https://www.google.com/recaptcha/api.js'></script>
```

* go back to register module and edit recaptchalib.php
```bash
# On line 144, change the return to this
return '<div class="g-recaptcha" data-sitekey="'. $pubkey.'"></div>

# On line 147, change the whole <iframe> thing with this
<iframe src="'. $server . '/fallback?k=' . $pubkey . $errorpart . '" height="300" width="500" frameborder="0"></iframe>
```

### Built With

* [PHP](https://example.com/)
* [MySQL](https://example.com/)
* [HTML](https://example.com/)
