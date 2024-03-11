#!/bin/bash

# printing current directory for debugging purposes - aws-credentials
pwd

# exporting environment variables set up in AWS CodeBuild
export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key
export AWS_DEFAULT_REGION=$region_key

# Use AWS CLI for authentication and other operations
aws ec2 describe-instances