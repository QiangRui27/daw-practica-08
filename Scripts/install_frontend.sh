#!/bin/bash

# Para mostrar los comandos que se van ejecutando

set -x 

#Actualizamos los repo
apt uptade -y

#Actualizamos los paquetes
apt upgrade -y

#Instalamos el servidor web apache
apt install apache2 -y



#Instalamos php y los modulos necesarios
apt install php libapache2-mod-php php-mysql -y

#copiar el archivo de configuracion de apache

cp ../conf/000-default.conf /etc/apache2/sites-available/000-default.conf

systemctl restart apache2
