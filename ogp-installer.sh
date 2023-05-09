#!/bin/bash

update_system(){
    sudo apt -y update
    sudo apt -y upgrade
}

install_panel(){
    apt install bc -y
    sudo apt-get -y install apache2 curl subversion php7.4 php7.4-gd php7.4-zip libapache2-mod-php7.4 php7.4-curl php7.4-mysql php7.4-xmlrpc php-pear phpmyadmin mariadb-server-10.3 php7.4-mbstring git php-bcmath
	wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/Debian-Ubuntu/ogp-panel-latest.deb" -O "ogp-panel-latest.deb"
	sudo dpkg -i "ogp-panel-latest.deb"
	sed -i "s/^bind-address.*/bind-address=0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"
	sudo mysql_secure_installation

	sudo cat /root/ogp_panel_mysql_info
	sudo cat /root/ogp_user_password
}

install_agent(){
    sudo apt-get -y install libxml-parser-perl libpath-class-perl perl-modules screen rsync sudo e2fsprogs unzip subversion libarchive-extract-perl pure-ftpd libarchive-zip-perl libc6 libgcc1 git curl
    sudo apt-get -y install libc6-i386
    sudo apt-get -y install libgcc1:i386
    sudo apt-get -y install lib32gcc1
    sudo apt-get -y install libhttp-daemon-perl
    wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/Debian-Ubuntu/ogp-agent-latest.deb" -O "ogp-agent-latest.deb"
    sudo dpkg -i "ogp-agent-latest.deb"

    sudo cat /root/ogp_user_password
    rm -rf /root/ogp-agent-latest.deb
}

install_obsidian(){
    cd /tmp
    wget https://github.com/hmrserver/Obsidian/archive/refs/heads/master.zip
    sudo apt-get install unzip
    unzip master.zip
    cd Obsidian-master/themes && cp -R Obsidian /var/www/html/themes
}

echo "Welcome to the revised Open Game Panel installation script! Please select an option:"
echo "1. Install OGP Panel"
echo "2. Install OGP Agent"
echo "3. Install Obsidian Theme"
echo "4. Script Credits"
echo "5. Exit"

read -p "Enter your choice [1-5]: " choice

case $choice in
  1)
    echo "Installing OGP Panel..."
    update_system
    install_panel
    echo "[OGP INSTALLER] OGP Panel Installation Complete"
    ;;
  2)
    echo "Installing OGP Agent..."
    update_system
    install_agent
    echo "[OGP INSTALLER] OGP Agent Installation Complete!"
    ;;
   3)
    echo "Installing Obsidian Theme..."
    install_obsidian
    echo "[OGP INSTALLER] Obsidian Theme Installation Complete!"
    ;;
  4)
    echo "This automatic open game panel installation script is made by CarlR"
    echo "All rights has been reserved 2023"
    ;;
  5)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please select an option [1-5]."
    ;;
esac

echo "Run ./ogp-installer.sh to access the installation script"
