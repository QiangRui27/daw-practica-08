#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -x

# Definición de variables

source variables.sh

rm -mf /var/www/html/*

# Descargamos el código fuente de wordpress
wget https://github.com/PrestaShop/PrestaShop/releases/download/8.0.0/prestashop_8.0.0.zip --output-document /tmp/prestashopfull.zip

# Actualizamos los repositorios
apt update

#Instalamos el descompresor de paquetes zip si no está instalado
apt install unzip -y

# Eliminamos si hubiese alguna instalación anterior
rm -rf /var/www/html/prestashop

# Descomprimimos el archivo .zip con el con todo lo de prestashop
unzip /tmp/prestashopfull.zip -d /tmp/prestashopfull

# Descomprimimos el archivo .zip con el con el codigo de prestashop
unzip /tmp/prestashopfull/prestashop.zip -d /var/www/html

# Instalamos prestashop con el comando que nos dan
php index_cli.php --domain=practicaprestashop8.hopto.org --db_server= 172.31.79.78 --db_name=$DB_NAME --db_user=$DB_USER --db_password=$DB_PASSWORD --prefix=myshop_ --email=$EMAIL --password=usuario