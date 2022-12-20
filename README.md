# daw-practica-08
Practica 08 de despliegue del IES celia Viñas


# Tareas a realizar
En esta práctica tendrá que realizar la implantación de la aplicación web PrestaShop en dos instancias EC2 de Amazon Web Services (AWS).

A continuación se describen muy brevemente algunas de las tareas que tendrá que realizar.

1. Crea dos grupos de seguridad, uno para la máquina que hará de FrontEnd (Servidor Web) y otro para la máquina de BackEnd (Servidor de Base de Datos).
    * El grupo de seguridad del FrontEnd debe permitir el acceso a los puertos 22 (SSH), 80 (HTTP) y 443 (HTTPS).
    * El grupo de seguridad del BackEnd debe permitir el acceso a los puertos 22 (SSH) y 3306 (MySQL).

2. Crea dos instancias EC2 en AWS que tengan al menos 2GB de memoria RAM. Una de las instancias será el FrontEnd y la otra el BacekEnd. Tenga en cuenta que tendrá que asignarle el grupo de seguridad correspondiente a cada una de las instancias.

3. La Amazon Machine Image (AMI) que vamos a seleccionar para esta práctica será una Community AMI con la última versión de Ubuntu Server.

4. Crea un par de claves (pública y privada) para conectar por SSH con su instancia. También puede hacer uso de la clave privada vockey.pem (labsuser.pem) que tiene asignada por defecto en AWS Academy.

5. Crea una dirección IP elástica y asígnala a la instancia EC2 que hará de FrontEnd (Servidor Web).

6. Registra un nombre de dominio en algún proveedor de nombres de dominio gratuito. Por ejemplo, puede hacer uso de [No-IP][10] o [Freenom][11].

7. Configura los registros DNS del proveedor de nombres de dominio para que el nombre de dominio de ha registrado pueda resolver hacia la dirección IP elástica de su instancia EC2 de AWS.

8. Realice la instalación de la pila LAMP y el despliegue de PrestaShop.

9. Tenga en cuenta que también tendrá que instalar y configurar el cliente ACME [Certbot] en su instacia EC2 de AWS, para solicitar un certificado SSL/TLS de [Let’s Encrypt].

10. Compruebe que puede acceder desde un navegador web a la tienda de PrestaShop que acaba de desplegar, haciendo uso del nombre de dominio que ha registrado a través de HTTPS.

#

En cuanto a la pila lamp a dos niveles es igual que en la practuca de wordpress, en el front se instalara apache y php con los modulos necesarios y en el back mysql donde se creara la base de datos.

Lo que hay distinto de esta practica es que en vez de instalar wordprees instalaremos prestashop la cual descargaremos el codigo fuente con wget y descomprimiremos con unzip , el zip que se ha descargado, pero ojo, deberemos de descomprimir otro zip ya que el codigo viene empaquetado dentro en un zip.

Ya teniendo el codigo lo moveremos al directorio apache.

Antes de realizar la instalación de PrestaShop utilizaremos el script [PhpPsInfo][26] para comprobar si nuestro entorno cumple todos los requisitos necesarios para la aplicación.

Tendremos que descargar el script de [PhpPsInfo][26] de un repositorio de GitHub y guardarlo en un directorio que sea accesible desde el servidor web. Una vez hecho esto, deberemos de acceder a este script desde la IP pública del servidor. Para ver el contenido tendrá que autenticarse con las credenciales que están definidas en el archivo phppsinfo.php.
En este vreremos que hay algunos avisosque deben corregirse sobre la configuración de las directivas de php.ini.

  * memory-limit. Establece el máximo de memoria en bytes que un script puede consumir.
  * max-input-vars. Cuantas variables de entrada pueden ser aceptadas en un formulario.
  * post-max-size. Define el tamaño máximo de datos de POST permitidos.
  * upload-max-filesize. El tamaño máximo de un fichero subido.
  
Estos los cambiaremos con el comando sed

Después de comprobar que esta todo perfecto procedemos a la instalación de prestashop usando el siguiente comando

- Instalamos prestashop con el comando que nos dan
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

Al terminar usaremos el comando chown permite cambiar el propietario de un archivo o directorio :
chown -R www-data:www-data /var/www/html

y por ultimo borramos los archivos del directorio temporal tmp y el install de /var/www/html, este último para pode acceder como admin
