	FROM debian:jessie
	MAINTAINER Black <blacknovaa@gmail.com>




	RUN DEBIAN_FRONTEND=noninteractive apt-get update 
	RUN DEBIAN_FRONTEND=noninteractive apt-get -f -y upgrade 
	RUN DEBIAN_FRONTEND=noninteractive apt-get install -f -y apt-utils 
	RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections 
	RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections 
	RUN DEBIAN_FRONTEND=noninteractive apt-get install -f -y mysql-server && \
	 DEBIAN_FRONTEND=noninteractive apt-get install -f -y apache2 && \
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
	RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -f -y 
	RUN sed -i -e 1c"<VirtualHost *:8080>" /etc/apache2/sites-available/000-default.conf 
	RUN  sed -i -e 12c"DocumentRoot /var/www/html" /etc/apache2/sites-available/000-default.conf 
	RUN sed -i -e 5c"Listen 8080" /etc/apache2/ports.conf 
	RUN cd /var/www/html/ 
	RUN wget -P /var/www/html/ http://netcologne.dl.sourceforge.net/project/owndms/owndms_45.zip 
	RUN unzip /var/www/html/owndms_45.zip -d /var/www/html/ 
	RUN rm -r /var/www/html/owndms_45.zip 
	RUN rm  /var/www/html/index.html 
	RUN cd /var/www/html/owndms 
	RUN chmod 777 /var/www/html/owndms/upload/ 
	RUN DEBIAN_FRONTEND=noninteractive apt-get update -y 
	RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  
	RUN mv /var/www/html/owndms/includes/config.php.dist /var/www/html/owndms/includes/config.php 
	RUN sed -i -e 5c"\$_db_username =\ "\"root"\";" /var/www/html/owndms/includes/config.php 
	RUN sed -i -e 6c"\$_db_passwort =\ "\"root"\";" /var/www/html/owndms/includes/config.php 
	RUN /etc/init.d/apache2 restart
	RUN sed -i -e 47c"\bind-address            = 127.0.0.2" /etc/mysql/my.cnf 
	RUN sed -i -e 20c"\port            = 3307" /etc/mysql/my.cnf 
	RUN sed -i -e 38c"\port            = 3307" /etc/mysql/my.cnf 
	RUN sed -i -e 1c"\127.0.0.2 	localhost2" /etc/hosts 
	RUN sed -i -e 2c"\127.0.0.2	Blacks-Server2" /etc/hosts 
	
	
	RUN /etc/init.d/mysql restart
