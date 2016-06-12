	FROM httpd:2.4
	FROM debian:jessie
	MAINTAINER Black <blacknovaa@gmail.com>




	RUN  DEBIAN_FRONTEND=noninteractive apt-get update \
	&&  DEBIAN_FRONTEND=noninteractive apt-get -f -y upgrade \
	&&  echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
	&&  echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
	&&  DEBIAN_FRONTEND=noninteractive apt-get install -f -y mysql-server \
	&&  DEBIAN_FRONTEND=noninteractive apt-get install -f -y apache2 \
		 wget \
		 zip \
		 imagemagick \
		 hplip \
		 php5-imagick \
		 sudo \
		 unoconv \
		 sane \
		 php5-mysql \
		 nano \
		 php5 \
		 libapache2-mod-php5 \
		 libtiff-tools \
		 libusb-1.0-0-dev \
   		 libusb-dev 
	RUN  DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -f -y \
	&&  sed -i -e 1c"<VirtualHost *:8080>" /etc/apache2/sites-available/000-default.conf \
	&&   sed -i -e 12c"DocumentRoot /var/www/html" /etc/apache2/sites-available/000-default.conf \
	&&  sed -i -e 5c"Listen 8080" /etc/apache2/ports.conf \
	&&  cd /var/www/html/ \
	&&  wget -P /var/www/html/ http://netcologne.dl.sourceforge.net/project/owndms/owndms_45.zip \
	&&  unzip /var/www/html/owndms_45.zip -d /var/www/html/ \
	&&  rm -r /var/www/html/owndms_45.zip \
	&&  rm  /var/www/html/index.html \
	&&  cd /var/www/html/owndms \
	&&  chmod 777 /var/www/html/owndms/upload/ \
	&&  DEBIAN_FRONTEND=noninteractive apt-get update -y \
	&&  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  \
	&&  mv /var/www/html/owndms/includes/config.php.dist /var/www/html/owndms/includes/config.php \
	&&  sed -i -e 5c"\$_db_username =\ "\"root"\";" /var/www/html/owndms/includes/config.php \
	&&  sed -i -e 6c"\$_db_passwort =\ "\"root"\";" /var/www/html/owndms/includes/config.php \
	
	&&  /etc/init.d/apache2 restart \
	&&  sed -i -e 47c"\bind-address            = 127.0.0.2" /etc/mysql/my.cnf \
	&&  sed -i -e 20c"\port            = 3307" /etc/mysql/my.cnf \
	&&  sed -i -e 38c"\port            = 3307" /etc/mysql/my.cnf \

	&&  /etc/init.d/mysql restart

