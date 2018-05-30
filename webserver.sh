#!/bin/bash

#Auto installer webserver for debian 9

# preconfig mariadb
sudo apt install debconf-utils -y;
sudo su -c "debconf-set-selections <<< 'mariadb-server mysql-server/root_password password admin123';";
sudo su -c "debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password admin123';";
# bash -c "sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password admin123';";
# bash -c "sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password admin123';";

#install mariadb
sudo apt install software-properties-common dirmngr -y;
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8;
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.ufscar.br/mariadb/repo/10.2/debian stretch main';
sudo apt update;
sudo apt install mariadb-server -y;

#install php 7.1
sudo apt install apt-transport-https ca-certificates -y;
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg;
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list;
sudo apt update;
sudo apt install php7.1-fpm php7.1-cli php7.1-bcmath php7.1-curl php7.1-gd php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-soap php7.1-xsl php7.1-zip php7.1-json php7.1-xdebug -y;
sudo phpenmod xdebug;

#install apache
sudo apt install apache2 -y;
sudo apt install libapache2-mod-fcgid -y;
sudo a2enmod rewrite proxy_fcgi;
sudo a2enconf php7.1-fpm;
sudo service apache2 restart;

#fix user
sudo sed -i.BAK "s;www-data;$USER;" /etc/apache2/envvars;
sudo sed -i.BAK "s;www-data;$USER;" /etc/php/7.1/fpm/pool.d/www.conf;
sudo service apache2 restart;
sudo service php7.1-fpm restart;

#node 8
# sudo apt install curl -y;
# curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - ;
# sudo apt install -y nodejs;

#phpmyadmin: will be implemented in future

#composer
sudo wget https://getcomposer.org/download/1.6.5/composer.phar -O /usr/local/bin/composer;
sudo chmod +x /usr/local/bin/composer;

#magerun2
sudo wget https://files.magerun.net/n98-magerun2.phar -O /usr/local/bin/mr2;
sudo chmod +x /usr/local/bin/mr2;