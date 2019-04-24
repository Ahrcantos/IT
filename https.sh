#! /bin/bash


#Only Listen on Port 443

sed -i -e "s/Listen 80//g" /etc/apache2/ports.conf

#Create self signed Certificate
cd /var/www/cert
#Rsa Key
openssl genrsa -out domain.key 2048
#CSR
openssl req -new -key domain.key -out domain.csr \
-subj "/C=DE/ST=NRW/L=KaLi/O=Test Inc/OU=Test Department/CN=localhost"
#Certificate
openssl x509 -req -key domain.key -in domain.csr -out domain.crt -days 365


#Add SSL to Apache2 Config

#Load Module SSL
echo "LoadModule ssl_module modules/mod_ssl.so" >> /etc/apache2/apache2.conf

#SSL on port 443
echo "<VirtualHost *:443>" >> /etc/apache2/apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo "SSLEngine on" >> /etc/apache2/apache2.conf
echo "SSLCertificateFile \"/var/www/cert/domain.crt\"" >> /etc/apache2/apache2.conf
echo "SSLCertificateKeyFile \"/var/www/cert/domain.key\"" >> /etc/apache2/apache2.conf
echo "</VirtualHost>" >> /etc/apache2/apache2.conf
