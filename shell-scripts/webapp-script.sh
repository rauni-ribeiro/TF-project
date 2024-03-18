#!/bin/bash

# printing current directory for debugging purposes - Webapp-scripts
pwd

# exit on failure mode
set -eu

# Add systemd configuration to wsl.conf
sudo nano /etc/wsl.conf <<EOF
[boot]
systemd=true
EOF

# Install Apache HTTP server
sudo yum update -y
sudo yum install -y httpd

# Start and enable Apache server
sudo systemctl start httpd
sudo systemctl enable httpd

# checking for current status of Apache server
sudo systemctl status httpd

# Copying the index.html file from our S3 bucket to /var/www/html/ (this is our local machine's directory)
sudo aws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read

# Restarting Apache server in order to fetch the content of the index.html file
sudo systemctl restart httpd

# NOTE: Now, on your browser, copy your public ipv4 address and add it with port :80 (at the ending) to check whether the server is indeed running. Ex: 10.123.533.4:80  / <IPv4address>:80