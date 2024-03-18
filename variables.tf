variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0d7a109bf30624c99"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "myTFprojectkey"
}

variable "s3_path_key" {
  type      = string
  default   = "Users/macbookpro/Documents/TF-CodeBuild-Project/terraform.tfstate"
  sensitive = true
}

variable "s3_bucket_name" {
  type    = string
  default = "tfproject-us-east-1-tfstate"
}

variable "webserver-sample" {
  type = string
  default = "web-server-sample"
}

variable "aws_iam_roles" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/AWSCodeBuildReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}

variable "user_data_webserver_script" {
  default = <<SCRIPT
#!/bin/bash
sudo su
yum update -y
yum install -y aws-cli
aws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read
systemctl start httpd
systemctl enable httpd
SCRIPT
}