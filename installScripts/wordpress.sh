#!/bin/sh
#
# source <(curl -s https://raw.githubusercontent.com/Hitman007/Remote-BDD-Setup/master/installScripts/wordpress.sh)
# DeMomentSomTres Export
#
sudo apt-get -y update
sudo apt-get -y upgrade
sudo chmod -R 777 /var/www
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get -f install
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install mysql-server
sudo apt-get -y install nodejs-legacy
sudo apt-get -y install xfce4
sudo apt-get -y install vnc4server
sudo apt-get -y install php
sudo apt-get -y install php-curl
sudo apt-get -y install php-gd
sudo apt-get -y install php-mbstring
sudo apt-get -y install php-mcrypt
sudo apt-get -y install php-xml
sudo apt-get -y install php-xmlrpc
sudo apt-get -y install firefox
sudo apt-get -y install default-jdk
sudo apt-get -y install libxss1
sudo apt-get -y install libappindicator1
sudo apt-get -y install libindicator7
sudo apt-get -y install npm
sudo apt-get -y install zip
sudo apt-get -y install unzip
sudo apt-get -y install php-zip

#sudo apt-get -y install lamp-server^
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

sudo a2enmod rewrite

# Install Wordpress:
sudo chmod -R 777 /var/www
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv -v /var/www/html/wordpress/* /var/www/html/
sudo rm -fr /var/www/html/wordpress
sudo rm /var/www/html/index.html
sudo rm /var/www/html/latest.tar.gz
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/plugins
sudo chmod -R g+w /var/www/html/wp-content/themes

mysql -u root -ppassword << EOF
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

# Wordpress plugins:
cd /var/www/html/wp-content/plugins
sudo rm -fr akismet
sudo rm hello.php
sudo git clone https://github.com/Hitman007/Wordpress-Pickles.git
sudo git clone https://Hitman007@bitbucket.org/Hitman007/crg_mods.git

#install Wordpress CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Install ChromeDriver.
wget -N http://chromedriver.storage.googleapis.com/2.27/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/share/
sudo chmod +x /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver

#install phantomJS
sudo apt-get -y install build-essential chrpath libssl-dev libxft-dev
sudo apt-get -y install libfreetype6 libfreetype6-dev
sudo apt-get -y install libfontconfig1 libfontconfig1-dev
#to run phantomjs:
# ./phantomjs --webdriver=4444

sudo apt-get clean
sudo reboot
