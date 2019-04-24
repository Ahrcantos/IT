#! /bin/bash


#Install
apt install apache2 apache2-utils libapache2-mod-php7.2 -y
apt install php7.2
a2enmod php7.2
rm /var/www/html/index.html


#Directory Setup
mkdir /var/www/cert
chmod 777 /var/www/cert

mkdir /var/www/html/secret
chmod 777 /var/www/html/secret

touch /var/www/html/messages
chmod 666 /var/www/html/messages

cp index.php /var/www/html/index.php
chmod 666 /var/www/html/index.php

cp -r secret/* /var/www/html/secret
chmod 777 /var/www/html/secret

mkdir /var/www/pwds
chmod 777 /var/www/pwds

#Change Config
sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

#Add htaccess to secret directory
touch /var/www/html/secret/.htaccess
chmod 666 /var/www/secret/.htaccess

echo "AuthType Basic" >> /var/www/html/secret/.htaccess
echo "AuthName \"Password Required\"" >> /var/www/html/secret/.htaccess
echo "AuthUserFile \"/var/www/pwds/.htpasswd\"" >> /var/www/html/secret/.htaccess
echo "Require user pascal" >> /var/www/html/secret/.htaccess

#Create user with password
htpasswd -b -c /var/www/pwds/.htpasswd pascal 12345


#Restart Server
systemctl restart apache2
