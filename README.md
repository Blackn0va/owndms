After pulling you can start the container with:

" " 

After starting the container, you have to change 1 Strings in the /etc/hosts filee because we have 2 webservers, and we have to change the ip address with:

 sed -i -e 1c"\127.0.0.2            = localhost2" /etc/hosts 
