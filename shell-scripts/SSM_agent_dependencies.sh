sudo yum install ruby -y
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo chmod +x ./install
sudo ./install auto
sudo systemctl status amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent