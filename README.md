After pulling you can start the container with e.g.

docker run --net=host black/owndms --add-host="localhost2:127.0.0.2"

OR.

docker run -it --add-host 127.0.0.2 black/owndms cat /etc/hosts

After starting the container, you have to change 1 Strings in the /etc/hosts filee because we have 2 webservers, and we have to change the ip address with:

 sed -i -e 1c"\127.0.0.2            = localhost2" /etc/hosts 
