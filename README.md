# Multimesh workshop

## Requirements

- deployed EC2 instance
- Decipher quickstart certs
- Decipher nexus login

## Deploying an EC2 instance

To get started you will need to deploy an AWS instance using the AMI `ami-01c64bbddbbb64adf`.

First, create a new security group with a TCP rule to allow traffic on port `30000` and enable SSH connections:

```sh
# Create group
aws ec2 create-security-group --group-name multimesh-workshop --description "Security group for Multimesh workshop"
# Add SSH
aws ec2 authorize-security-group-ingress --group-name multimesh-workshop --protocol tcp --port 22 --cidr 0.0.0.0/0
# Add mesh ingress
aws ec2 authorize-security-group-ingress --group-name multimesh-workshop --protocol tcp --port 30000 --cidr 0.0.0.0/0
```

You'll also need to get the name of the key-pair you use to login to AWS ec2 instances. You can find this in your EC2 dashboard under NETWORK & SECURITY -> Key Pairs.
 
Using the security group ID returned from the first command and your key name, execute:

```sh
aws ec2 run-instances --image-id ami-01c64bbddbbb64adf --count 1 --key-name <key-pair-name> --instance-type t2.large --security-group-ids <security-group-id>
```

Once the instance is up, you can start working through the [workshop material.](https://github.com/kaitmore/multimesh-workshop/blob/master/workshop.md)