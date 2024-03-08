# Configuring the provider (AWS) and its region - Please notice that you can choose whatever region you prefer
provider "aws" {
  region = var.region_name
}

# Configuring EC2 instance details
resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "webserver"
  }
  iam_instance_profile = aws_iam_role.ec2_role.name #This provides our EC2 instance authentication - check README.md for more information!
  vpc_security_group_ids = [aws_security_group.SG.id]  #Assigning our Security Group ID to our EC2 instance.
}

terraform {
  backend "s3" {
    bucket = "tfproject-us-east-1-tfstate"
    key = "build/terraform.tfstate"  #specify the state file name + create folder
    region = "us-east-1"
    profile = "default"
  }
}

#creating security group for our project
resource "aws_security_group" "SG" {
  name        = "TFproject-SG"
  description = "Allow HTTP and SSH traffic from any source"

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
  role = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildReadOnlyAccess"
}