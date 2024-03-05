#!/bin/sh

#exit on failure mode
set -eu


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

