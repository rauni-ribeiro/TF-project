variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0440d3b780d96b29d"
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