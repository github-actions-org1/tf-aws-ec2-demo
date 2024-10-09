#!/bin/bash

sudo yum -y install httpd git 
sudo yum -y  update 

cd /tmp
git clone https://github.com/emage-course/portfolio.git
sleep 15s
cd /tmp/portfolio/website
cp -r *  /var/www/html/ 
sudo systemctl stop httpd
sudo systemctl start httpd
sudo systemctl enable httpd

