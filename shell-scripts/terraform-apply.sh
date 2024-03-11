#!/bin/bash

# printing current directory for debugging purposes - Terraform apply
pwd

# Clone the GitHub repository containing our Terraform configuration
git clone https://github.com/rauni-ribeiro/TF-project.git

# Navigate to the directory with our Terraform configuration
cd TF-project

# Initialize Terraform
terraform init

# Apply the Terraform configuration
terraform apply -auto-approve