#!/bin/bash

export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="YOUR_DEFAULT_REGION"

# Use AWS CLI for authentication and other operations
aws ec2 describe-instances