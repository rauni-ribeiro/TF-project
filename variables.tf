variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0c101f26f147fa7fd"
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
  type    = string
  default = "web-server-sample"
}

variable "aws_iam_roles" {
  type    = list(string)
  default = ["arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::098741617361:policy/AllowPassRole", "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"]
}

variable "user_data_webserver_script" {
  default = "#!/bin/bash\nsudo yum update -y\nsudo yum install -y aws-cli httpd\naws s3 cp s3://tfproject-html/index.html /var/www/html/ --metadata-directive REPLACE --acl public-read\nsudo systemctl start httpd\nsudo systemctl enable httpd\nsudo yum install ruby -y\nsudo yum install wget\ncd /home/ec2-user\nwget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install\nchmod +x ./install\nsudo ./install auto\nsudo service codedeploy-agent start\nsudo chkconfig codedeploy-agent on"
}
