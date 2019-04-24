#! /bin/bash


#Only Listen on Port 443

sed -i -e "s/Listen 80//g" /etc/apache2/ports.conf

#Create self signed Certificate
cd /var/www/certi
#Rsa Key
openssl genrsa -out domain.key 2048
#CSR
openssl req -new -key domain.key -out domain.csr \
-subj "/C=DE/ST=NRW/L=KaLi/O=Test Inc/OU=Test Department/CN=localhost"
#Certificate
openssl x509 -req -in domain.csr -out domain.crt -days 365


#Add SSL to Apache2 Config

