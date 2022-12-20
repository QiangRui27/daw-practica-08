#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -x

# Definición de variables

source variables.sh

rm -rf /var/www/html/* 

rm -rf /var/www/html/index.html

# Descargamos el código fuente de wordpress
wget https://github.com/PrestaShop/PrestaShop/releases/download/8.0.0/prestashop_8.0.0.zip --output-document /tmp/prestashopfull.zip
wget https://github.com/PrestaShop/php-ps-info/archive/refs/tags/v1.1.zip --output-document /tmp/phppsinfo.zip


# Actualizamos los repositorios
apt update

#Instalamos el descompresor de paquetes zip si no está instalado
apt install unzip -y

# Eliminamos si hubiese alguna instalación anterior
rm -rf /var/www/html/*

# Descomprimimos el archivo .zip con el con todo lo de prestashop
unzip /tmp/prestashopfull.zip -d /tmp/prestashopfull
unzip /tmp/phppsinfo.zip -d /tmp/phppsinfo


# Descomprimimos el archivo .zip con el con el codigo de prestashop

unzip /tmp/prestashopfull/prestashop.zip -d /var/www/html
mv /tmp/phppsinfo/php-ps-info-1.1/phppsinfo.php -d /var/www/html

#movemos el codigo al drectorio de apache
mv /tmp/phppsinfo/php-ps-info-1.1/phppsinfo.php /var/www/html/


apt install php-curl -y
apt install php-gd -y
apt install php-intl -y
apt install php-mbstring -y

sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 128M/" /etc/php/8.1/apache2/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 120M/" /etc/php/8.1/apache2/php.ini

chmod -R 755 /var/www/html/*
systemctl restart apache2

# Instalamos prestashop con el comando que nos dan
php /var/www/html/install/index_cli.php \
--domain=$DOMAIN \
--db_server=$DB_SERVER \
--db_name=$DB_NAME \
--db_user=$DB_USER \
--db_password=$DB_PASSWORD \
--prefix=myshop_ \
--email=$EMAIL \
--password=$PASSWORD \
--ssl=1

apt-get install php-zip php-simplexml


chown -R www-data:www-data /var/www/html

rm -rf /var/www/html/php-cs-fixer.dist.php
rm -rf prestashopfull
rm -rf prestashopfull.zip

rm -rf /var/www/html/install