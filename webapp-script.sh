#!/bin/bash

# Exit on failure mode
set -eu

# Install Apache HTTP server
yum update -y
yum install -y httpd

# Start and enable Apache server
sleep 10
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a simple HTML page
echo "<h1>Hello World!</h1>" > /var/www/html/index.html