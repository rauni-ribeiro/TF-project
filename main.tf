# Configuring the provider (AWS) and its region - Please notice that you can choose whatever region you prefer
provider "aws" {
  region = var.region_name
}

#creating an IAM role to authenticate Environment Variables (used to authenticate our ec2 instance)
resource "aws_iam_role" "ec2_role" {

  name = "EC2role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#creating the policy attachment for our IAM role (ec2_role) 
resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  count = length(var.aws_iam_roles)
  role = aws_iam_role.ec2_role.name
  policy_arn = var.aws_iam_roles[count.index]
}


#creating an IAM instance profile to associate with the EC2 instance
resource "aws_iam_instance_profile" "tfproject_profile" {
  name = "tfproject_profile"
  role = aws_iam_role.ec2_role.name
}

# Configuring EC2 instance details
resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "webserver"
  }
  iam_instance_profile = aws_iam_instance_profile.tfproject_profile.name #Associating the IAM instance profile with the EC2 instance.
  vpc_security_group_ids = [aws_security_group.SG.id]  #Assigning our Security Group ID to our EC2 instance.
  subnet_id = aws_subnet.tf_subnet.id #Assigning our Subnet ID to our EC2 instance.
  associate_public_ip_address = true #assigning a public IPv4 address to our EC2 instance.
  user_data = var.user_data_webserver_script # Assigning the webserver script to our user
}

terraform {
  backend "s3" {
    bucket = "tfproject-us-east-1-tfstate"
    key = "build/terraform.tfstate"  #specify the state file name + creates a build folder
    region = "us-east-1"
    profile = "default"
  }
}

#creating security group for our project
resource "aws_security_group" "SG" {
  name        = "TFproject-SG"
  description = "Allow HTTP and SSH traffic from any source"
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TFproject-SG"
  }
}

#creating a VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TFproject-VPC"
  }
}

#Creating an Internet Gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "TFproject-IGW"
  }
}

#Creating a Subnet 
resource "aws_subnet" "tf_subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "TFproject-Subnet"
  }
}

#Creating a Route Table
resource "aws_route_table" "tf_route_table" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }

  tags = {
    Name = "TFproject-RouteTable"
  }
}

#Associating the Route Table with the Subnet
resource "aws_route_table_association" "tf_subnet_association" {
  subnet_id      = aws_subnet.tf_subnet.id
  route_table_id = aws_route_table.tf_route_table.id
}


#Creating an autoscaling group  
resource "aws_autoscaling_group" "tf_auto_scaling_group" {
  name = "TFproject-ASG"
  desired_capacity = 3
  max_size = 6
  min_size = 1

  vpc_zone_identifier = [aws_subnet.tf_subnet.id]

  launch_template {
    id = aws_launch_template.tf_launch_template.id
    version = "$Latest"
  }

}

#Creating a Launch Template
resource "aws_launch_template" "tf_launch_template" {
  name = "TFproject-LaunchTemplate"
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = base64encode(var.user_data_webserver_script)
}
