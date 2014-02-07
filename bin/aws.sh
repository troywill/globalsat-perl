#!/bin/bash
set -o nounset

host="ec2-54-215-211-54.us-west-1.compute.amazonaws.com"
host="ec2-54-215-227-49.us-west-1.compute.amazonaws.com"
user="ec2-user"
private_key="~/.ssh/keypair.pem"
private_key="/home/troy/.ssh/keypair.pem"

ssh -i ${private_key} ${user}@${host}
ssh -i ${private_key} ${user}@54.215.211.54
