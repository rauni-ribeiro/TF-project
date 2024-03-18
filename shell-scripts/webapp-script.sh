#!/bin/bash

sudo su
yum update -y
yum install -y httpd.x86_64
sudo aws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read
systemctl start httpd
systemctl enable httpd