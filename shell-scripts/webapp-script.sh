#!/bin/bash

# printing current directory for debugging purposes - Webapp-scripts
pwd

# exit on failure mode
set -eu

# Install Apache HTTP server
sudo yum update -y
sleep 4
sudo yum install -y httpd