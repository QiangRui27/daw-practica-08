#!/bin/bash

#incluimos las variables de configuracion
source variables.sh

# Para mostrar los comandos que se van ejecutando

set -x 

#Actualizamos los repo
apt update -y

#Actualizamos los paquetes
apt upgrade -y

#Instalamos el sistema gestor de BD MySQL
apt install mysql-server -y

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql


# Borramos la base de datos de wordpress por si ya estubiese instalada
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"

# Creamos la base de datos de wordpress
mysql -u root <<< "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Creamos el usuario de la base de datos
mysql -u root <<< "DROP USER IF EXISTS $DB_USER@'%';"
mysql -u root <<< "CREATE USER $DB_USER@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%';"
mysql -u root <<< "FLUSH PRIVILEGES;"