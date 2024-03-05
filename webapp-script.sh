#!/bin/sh

#exit on failure mode
set -eu

# Get private IP address of the newly deployed EC2 instance
private_ip=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=webserver" --query "Reservations[*].Instances[*].PrivateIpAddress" --output text)

# Connect to EC2 instance using private IP address
ssh -i newkey-TFproject ec2-user@$private_ip


<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Welcome to my website</h1>" > /var/www/html/index.html
EOF



#GUIDE

# yum install -y httpd = installs apache HTTP server
#systemctl start httpd = starts apache HTTP server
#systemctl enable httpd = enables apache HTTP server
#finally, writes the HTML content to /var/www/html/index.html
#.

