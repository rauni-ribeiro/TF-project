#!/bin/bash

#This will assign my environment variables to $my_access_key & $my_secret_key,
#meaning, I don`t need to use "aws configure" to sign in, anymore.
aws configure set aws_access_key_id $my_access_key
aws configure set aws_secret_access_key $my_secret_key