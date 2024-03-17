#!/bin/bash

# printing current directory for debugging purposes - Webapp-scripts
pwd

# exit on failure mode
set -eu

#Create an apache-script.sh file with the following contents:
cat << 'EOF' > apache-script.sh

sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo aws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read
sudo systemctl restart httpd
EOF

sudo chmod +x apache-script.sh
sudo ./apache-script.sh