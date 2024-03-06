#!/bin/bash

# Retrieve the secret values from AWS Secrets Manager
secret_response=$(aws secretsmanager get-secret-value --secret-id MyAccessSecret)

# Extract access key and secret key from the response
access_key=$(jq -r '.SecretString | fromjson | .access_key' <<< "$secret_response")
secret_key=$(jq -r '.SecretString | fromjson | .secret_key' <<< "$secret_response")

# Configure AWS CLI with the retrieved credentials
aws configure set aws_access_key_id $access_key
aws configure set aws_secret_access_key $secret_key

# Use AWS CLI for authentication and other operations
aws ec2 describe-instances