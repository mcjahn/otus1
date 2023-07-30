#!/bin/bash
set -e
#отключаем SELinux
setenforce 0
#отключаем firewall
systemctl stop firewalld
systemctl disable firewalld
#установка репозиториев, пакетов
yum install -y epel-release httpd git mc
yum install -y nginx
#забираем проект с github так же вносим конфиги на нашу систему
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
#включаем автозагрузку и запускаем сервисы
systemctl enable --now nginx
systemctl enable --now httpd
#качаем node_exporter
cd /home/mamaev/
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.0/node_exporter-1.6.0.linux-amd64.tar.gz
#разархивируем node_exporter
tar -xvf node_exporter-1.6.0.linux-amd64.tar.gz
cd /home/mamaev/node_exporter-1.6.0.linux-amd64
#создаем пользователя для запуска node_exporter
useradd --no-create-home --shell /usr/sbin/nologin node_exporter
#переносим файл
rsync --chown=node_exporter:node_exporter -arvuP node_exporter /usr/local/bin
cd /home/mamaev/otus1
rsync -abvuP /home/mamaev/otus1/node_exporter.service  /etc/systemd/system
systemctl enable --now node_exporter.service
echo "всё сделано!"
