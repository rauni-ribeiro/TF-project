# Configuring the provider (AWS) and its region - Please notice that you can choose whatever region you prefer
provider "aws" {
  region = var.region_name
}

# Configuring EC2 instance details
resource "aws_instance" "web-server-sample" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "web-server-sample"
  }
}

terraform {
  backend "s3" {
    bucket = var.s3_bucket_name
    key = var.s3_path_key  #specify the state file name + create folder
    region = var.region_name
    profile = "default"
  }
}