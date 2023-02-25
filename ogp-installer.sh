#!/bin/bash

set -e

######################################################################################
#                                                                                    #
# Software 'Open Game Panel Installer'                                               #
#                                                                                    #
# Copyright (C) 2023, CarlR, <carlr@sdchosting.tech>                                 #
#                                                                                    #
#   This program is free software: you can redistribute it and/or modify             #
#   it under the terms of the GNU General Public License as published by             #
#   the Free Software Foundation, either version 3 of the License, or                #
#   (at your option) any later version.                                              #
#                                                                                    #
#   This program is distributed in the hope that it will be useful,                  #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of                   #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                    #
#   GNU General Public License for more details.                                     #
#                                                                                    #
#   You should have received a copy of the GNU General Public License                #
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.           #
#                                                                                    #
# https://github.com/sdchosting/ogp-installer/blob/master/LICENSE                    #
#                                                                                    #
# This script is not associated with the official Pterodactyl Project.               #
# https://github.com/sdchosting/ogp-installer                                        #
#                                                                                    #
######################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

cyan() {
	echo -e "\\033[36;1m${@}\033[0m"
}

LOG_PATH="/var/log/ogp-installer.log

. /etc/os-release

echo -e "Your System Operating System: ${GREEN} $PRETTY_NAME"

update_system(){
    sudo apt -y update
    sudo apt -y upgrade
}

install_agent(){
    wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/Debian-Ubuntu/ogp-agent-latest.deb" -O "ogp-agent-latest.deb"
    sudo dpkg -i "ogp-agent-latest.deb"

    sudo cat /root/ogp_user_password
    rm -rf /root/ogp-agent-latest.deb
}

install_debian_ubuntu(){
	wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/Debian-Ubuntu/ogp-panel-latest.deb" -O "ogp-panel-latest.deb"
	sudo dpkg -i "ogp-panel-latest.deb"

	sudo cat /root/ogp_panel_mysql_info
	sudo cat /root/ogp_user_password
}

if [ "$ID" == "debian" ]; then

	apt install bc -y

	if [ $(echo "$VERSION_ID == 10 || $VERSION_ID == 9 || $VERSION_ID == 8" | bc -l) != 1 ]; then
		echo "Your Debian $VERSION_ID version not supported yet"
		exit
	fi

	if [ $(echo "$VERSION_ID == 10"|bc -l) == 1 ]; then

		echo "Debian 10 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php7.3 php7.3-gd php7.3-zip libapache2-mod-php7.3 php7.3-curl php7.3-mysql php7.3-xmlrpc php-pear mariadb-server php7.3-mbstring php-gettext git php-bcmath
		sudo apt-get -y install phpmyadmin

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."

	fi

	if [ $(echo "$VERSION_ID == 9"|bc -l) == 1 ]; then

		echo "Debian 9 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php7.0 php7.0-gd php7.0-zip libapache2-mod-php7.0 php7.0-curl php7.0-mysql php7.0-xmlrpc php-pear phpmyadmin mysql-server php7.0-mbstring php-gettext git php-bcmath

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	if [ $(echo "$VERSION_ID == 8"|bc -l) == 1 ]; then

		echo "Debian 8 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php5 php5-gd php5-xmlrpc php5-curl php5-mysql php-pear phpmyadmin mysql-server libapache2-mod-php5 git

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	if [ $(echo "$VERSION_ID == 7"|bc -l) == 1 ]; then

		sudo sed -i 's#<Directory /var/www.*#<Directory /var/www/html/>#g' /etc/apache2/sites-available/default
		sudo sed -i 's#DocumentRoot /var/www.*#DocumentRoot /var/www/html#g' /etc/apache2/sites-available/default
		sudo sed -i 's#<Directory /var/www.*#<Directory /var/www/html/>#g' /etc/apache2/sites-available/default-ssl
		sudo sed -i 's#DocumentRoot /var/www.*#DocumentRoot /var/www/html#g' /etc/apache2/sites-enabled/000-default
		sudo sed -i 's#<Directory /var/www.*#<Directory /var/www/html/>#g' /etc/apache2/sites-enabled/000-default
		sudo sed -i 's#DocumentRoot /var/www.*#DocumentRoot /var/www/html#g' /etc/apache2/sites-enabled/000-default
		sudo service apache2 restart

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."

	fi

	sudo mysql_secure_installation

	install_debian_ubuntu

fi


if [ "$ID" == "ubuntu" ]; then

	apt install bc -y
	
	if [ $(echo "$VERSION_ID == 20.04 || $VERSION_ID == 18.04 || $VERSION_ID == 16.04" | bc -l) != 1 ]; then
		echo "Your Ubuntu $VERSION_ID version not supported yet"
		exit
	fi

	if [ $(echo "$VERSION_ID == 20.04"|bc -l) == 1 ]; then

		echo "Ubuntu 20.04 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php7.4 php7.4-gd php7.4-zip libapache2-mod-php7.4 php7.4-curl php7.4-mysql php7.4-xmlrpc php-pear phpmyadmin mariadb-server-10.3 php7.4-mbstring git php-bcmath

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	if [ $(echo "$VERSION_ID == 18.04"|bc -l) == 1 ]; then

		echo "Ubuntu 18.04 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php7.2 php7.2-gd php7.2-zip libapache2-mod-php7.2 php7.2-curl php7.2-mysql php7.2-xmlrpc php-pear phpmyadmin mysql-server php7.2-mbstring php-gettext git php-bcmath

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	if [ $(echo "$VERSION_ID == 16.04"|bc -l) == 1 ]; then

		echo "Ubuntu 16.04 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php7.0 php7.0-gd php7.0-zip libapache2-mod-php7.0 php7.0-curl php7.0-mysql php7.0-xmlrpc php-pear phpmyadmin mysql-server php7.0-mbstring php-gettext git php-bcmath

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	if [ $(echo "$VERSION_ID == 14.04"|bc -l) == 1 ]; then

		echo "Ubuntu 14.04 Detected Updating & Installing Panel..."
		sleep 5

		update_system
		sudo apt-get -y install apache2 curl subversion php5 php5-gd php5-xmlrpc php5-curl php5-mysql php-pear phpmyadmin mysql-server libapache2-mod-php5 git

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."
	fi

	sed -i "s/^bind-address.*/bind-address=0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"

	sudo mysql_secure_installation

	install_debian_ubuntu
	
fi


if [ "$ID" == "centos" ]; then

	if [ $(echo "$VERSION_ID == 8 || $VERSION_ID == 7 || $VERSION_ID == 6" | bc -l) != 1 ]; then
		echo "Your CentOS $VERSION_ID version not supported yet"
		exit
	fi

	if [ $(echo "$VERSION_ID == 8"|bc -l) == 1 ]; then

		echo "CentOS 8 Detected Updating & Installing Panel..."
		sleep 5

		sudo yum -y update
		sudo dnf install epel-release
		sudo yum -y install epel-release wget subversion git
		sudo yum -y install mariadb-server
		sudo service mariadb restart
		sudo mysql_secure_installation
		sudo dnf config-manager --set-enabled powertools
		sudo yum -y install php-mysqlnd php-json php-zip php-bcmath

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."

	fi

	if [ $(echo "$VERSION_ID == 7"|bc -l) == 1 ]; then

		echo "CentOS 7 Detected Updating & Installing Panel..."
		sleep 5
		
		sudo yum -y install epel-release wget subversion git
		sudo yum -y install mariadb-server
		sudo service mariadb restart
		sudo mysql_secure_installation
		sudo yum -y install php-mysql phpMyAdmin

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."

	fi

	if [ $(echo "$VERSION_ID == 6"|bc -l) == 1 ]; then

		echo "CentOS 6 Detected Updating & Installing Panel..."
		sleep 5
		
		sudo yum -y install epel-release wget subversion git
		sudo yum -y install mysql-server
		sudo service mysqld restart
		sudo mysql_secure_installation
		sudo chkconfig mysqld on
		sudo yum -y install php-mysql phpMyAdmin

		sudo iptables -I INPUT 5 -i eth0 -p tcp -m tcp --dport 80 -j ACCEPT
		sudo iptables -I INPUT 5 -i eth0 -p tcp -m tcp --dport 443 -j ACCEPT
		sudo service iptables save
		sudo service iptables restart

        echo "${GREEN}OGP Panel Successfully Installed. Installing OGP Agent..."

	fi

	wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/CentOS/ogp_panel_rpm-1.0.0-1.noarch.rpm" -O "ogp_panel.rpm"
	sudo yum -y install "ogp_panel.rpm"

	sudo bash /var/www/html/create_db.sh
	
	sudo cat /root/ogp_panel_mysql_info

fi

if [ "$ID" == "debian" ]; then

    echo "Debian OS Detected Updating & Installing..."
    sleep 5

    #Updating
    update_system

    # Installing required packages
    sudo apt -y install libxml-parser-perl libpath-class-perl perl-modules screen rsync sudo e2fsprogs unzip subversion pure-ftpd libarchive-zip-perl libc6 libgcc1 git curl
    sudo apt -y install libc6-i386 lib32gcc1
    sudo apt -y install libhttp-daemon-perl

    # Checks version if it needs extra packages
    if [[ "$VERSION_ID" == "10" || "$VERSION_ID" == "9" || "$VERSION_ID" == "8" ]]; then
        sudo apt-get install -y libarchive-extract-perl        
    fi

    # Downloading and installing agent
    install_agent
    
    echo "${GREEN} OGP Agent Successfully Installed!"

fi


if [ "$ID" == "ubuntu" ]; then

    echo "Ubuntu OS Detected Updating & Installing..."
    sleep 5

    # Update 
    update_system

    # Installing required packages
    sudo apt-get -y install libxml-parser-perl libpath-class-perl perl-modules screen rsync sudo e2fsprogs unzip subversion libarchive-extract-perl pure-ftpd libarchive-zip-perl libc6 libgcc1 git curl
    sudo apt-get -y install libc6-i386
    sudo apt-get -y install libgcc1:i386
    sudo apt-get -y install lib32gcc1
    sudo apt-get -y install libhttp-daemon-perl

    # Downloading and installing agent
    install_agent
    
    echo "${GREEN} OGP Agent Successfully Installed!"

fi



if [ "$ID" == "centos" ]; then

    if [ "$VERSION_ID" == "8" ]; then

        echo "CentOS 8 Detected Installing..."
        sleep 5

        sudo yum -y update
        sudo dnf install epel-release
        sudo yum -y install epel-release wget subversion git
        sudo dnf config-manager --set-enabled powertools
        sudo dnf --enablerepo=powertools -y install perl-HTTP-Daemon
        sudo yum install -y perl-HTTP-Daemon perl-LWP-Protocol-http10 proftpd proftpd-utils perl-ExtUtils-MakeMaker glibc.i686 glibc libgcc_s.so.1 perl-IO-Compress-Bzip2
        sudo dnf -y install perl-CPAN
        sudo cpan Archive::Extract
        sudo yum -y install screen perl-Path-Class perl-XML-Parser

        echo "${GREEN} OGP Agent Successfully Installed!"

    fi

    if [ "$VERSION_ID" == "7" ]; then

        echo "CentOS 7 Detected Installing..."
        sleep 5

        sudo yum -y update
        sudo yum -y install epel-release wget subversion git
        sudo yum install -y perl-HTTP-Daemon perl-LWP-Protocol-http10 proftpd proftpd-utils perl-ExtUtils-MakeMaker glibc.i686 glibc libgcc_s.so.1 perl-IO-Compress-Bzip2
        sudo yum install -y perl-Archive-Extract

        echo "${GREEN} OGP Agent Successfully Installed!"

    fi


    if [ "$VERSION_ID" == "6" ]; then

        echo "CentOS 6 Detected Installing..."
        sleep 5

        sudo yum -y update
        sudo yum -y install epel-release wget subversion git
        sudo yum install -y perl-libwww-perl proftpd proftpd-utils perl-ExtUtils-MakeMaker glibc.i686 glibc libgcc_s.so.1 perl-IO-Compress-Bzip2
        sudo yum install -y perl-Archive-Extract

        sudo sed -i "s/^LoadModule\( \)*mod_auth_file.c/#LoadModule mod_auth_file.c/g" "/etc/proftpd.conf"
        sudo service proftpd restart

        echo "${GREEN} OGP Agent Successfully Installed!"

    fi

    # Downloading and installing agent
    wget -N "https://github.com/OpenGamePanel/Easy-Installers/raw/master/Linux/CentOS/ogp_agent_rpm-1.0.0-1.noarch.rpm" -O "ogp_agent.rpm"
    sudo yum install -y "ogp_agent.rpm"
    sudo cat /root/ogp_enc_key
    sudo cat /root/ogp_user_sudo_pass
    rm -rf /root/ogp_agent.rpm

    echo "Rate our company in: ${YELLOW} https://www.trustpilot.com/review/sdchosting.tech"
    echo "Script made by CarlR: ${YELLOW} https://github.com/carlsdc"
    echo "SDCHostings Discord Server: ${YELLOW} https://discord.gg/sdchostings"
    echo "©2023 SDCHostings All Rights Reserved"

fi