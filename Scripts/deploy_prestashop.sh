#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -x

# Definición de variables

source variables.sh

rm -mf /var/www/html/*

# Descargamos el código fuente de wordpress
wget https://github.com/PrestaShop/PrestaShop/releases/download/8.0.0/prestashop_8.0.0.zip --output-document /tmp/wordpress.zip

# Actualizamos los repositorios
apt update

#Instalamos el descompresor de paquetes zip si no está instalado
apt install unzip -y

