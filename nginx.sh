#!/bin/bash
#set -e
#отключаем SELinux
setenforce 0
#отключаем firewall
systemctl stop firewalld
systemctl disable firewalld
#установка репозиториев, пакетов
yum install -y epel-release httpd git mc
yum install -y nginx
git clone https://github.com/mcjahn/otus1.git
cd /home/mamaev/otus1
cp default.conf /etc/nginx/conf.d/
cp httpd.conf /etc/httpd/conf.d/default.conf
cp httpd1.conf /etc/httpd/conf/httpd.conf
cd /var/www/html/
mkdir /var/www/html1
mkdir /var/www/html2
#cd /home/mamaev/otus1
cp /home/mamaev/otus1/index.html /var/www/html/index.html
cp /home/mamaev/otus1/index1.html /var/www/html1/index.html
cp /home/mamaev/otus1/index2.html /var/www/html2/index.html
systemctl enable --now nginx
systemctl enable --now httpd
echo "всё сделано!"

