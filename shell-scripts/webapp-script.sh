#!/bin/bash

# printing current directory for debugging purposes - Webapp-scripts
pwd

# Exit on failure mode
set -eu

# Install Apache HTTP server
yum update -y
yum install -y httpd

# Start and enable Apache server
sleep 4
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page
echo "<h1>Hello World!</h1>" > /var/www/html/index.html