#Configuring the provider (AWS) and its region - Please notice that you can choose whatever region you prefer
provider "aws" {
  region = var.region
}

#Configuring EC2 instance details
resource "aws_instance" "web-server-sample" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}


#Storing the .tfstate file in AWS S3 bucket for better versioning and security 
terraform {
  backend "s3" {
    bucket = var.s3_bucket_name
    key    = var.s3_path_key
    region = var.region
  }
}