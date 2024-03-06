#!/bin/bash

# Create a new IAM role for EC2 instance
aws iam create-role --role-name MyEC2Role --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

# Attach a policy to the IAM role granting necessary permissions
aws iam attach-role-policy --role-name MyEC2Role --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess