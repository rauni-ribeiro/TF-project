#!/bin/bash

# Exit on failure mode
set -eu

# Install Apache HTTP server
yum update -y
yum install -y httpd

# Start and enable Apache server
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page
echo "<h1>Welcome to my website</h1>" > /var/www/html/index.html