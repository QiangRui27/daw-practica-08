#!/bin/bash

set -x 

#Variables de configuracion
#-------------------------------------------------------------------------------------------#
source variables.sh
#-------------------------------------------------------------------------------------------#


#nos instalamos el core de snap
snap install core

#actualizamos snap
snap refresh core

# Borramos la instalacion previa de cerbot con apt
apt-get remove certbot -y

# Instalamos el cliente de certbot con snapd
snap install --classic certbot

# Creamos un alias para el comando certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# Ejecutamos certbot para solicitar el certificado y configurar el servidor
certbot --apache -m $EMAIL --agree-tos --no-eff-email -d $DOMAIN