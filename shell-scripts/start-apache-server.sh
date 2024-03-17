# Start Apache server
sudo systemctl httpd start

# Enable Apache server to start on boot
sudo systemctl httpd on

# Checking the status of Apache server
sudo systemctl httpd status

# Copying the index.html file from S3 bucket to /var/www/html/
sudo aws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read

# Restart Apache server to fetch the content of index.html
sudo systemctl start httpd