# Overview
This Terraform project deploys an infrastructure on AWS, consisting of a Virtual Private Cloud (VPC) with two subnets, an Internet Gateway, 
Security Groups, an Amazon S3 bucket, EC2 instances, and an Application Load Balancer (ALB). The infrastructure is designed to host a web application using nginx.

# VPC Setup
The project creates a VPC with a specified CIDR block and two public subnets in different availability zones.
It also attaches an Internet Gateway to enable internet access for resources within the VPC.
Each subnet is associated with a route table, and the route table for public subnets has a default route to the Internet Gateway.

# S3 Bucket
An S3 bucket named "shradha-agarwal-terraform-project" is created. Two objects, "hello.jpg" and "welcome.jpg," are uploaded to the bucket using the specified source files.

# EC2 Instances
Two EC2 instances are launched, each in a different subnet.
IAM roles and policies are attached to the instances to grant them read-only access to S3. 
The instances are also associated with a security group allowing inbound traffic on ports 80 (HTTP) and 22 (SSH).

# Application Load Balancer (ALB)
An ALB is provisioned with a listener on port 80, forwarding traffic to a target group. 
The target group is associated with the EC2 instances, distributing incoming HTTP traffic across both instances.

# Variables
The project uses variables to parameterize inputs, allowing flexibility in customization.
Refer to the variable definitions in your Terraform configuration file for details. [variables.tf]

# Quick Start
Clone this repository:
```
git clone <repository_url>
cd <repository_directory>
terraform init
terraform apply
```

# Output
![Untitled (33)](https://github.com/shradha810/Terraform-AWS/assets/60320258/ff4f1bb7-21dd-4218-a95c-5da9c3f076cd)
![Untitled (34)](https://github.com/shradha810/Terraform-AWS/assets/60320258/573fbf65-45c6-4d9b-855c-fcdb86ad47b0)
![Untitled (36)](https://github.com/shradha810/Terraform-AWS/assets/60320258/fb1bce5a-b708-4346-b41d-e6bf749d32d4)
![Untitled (35)](https://github.com/shradha810/Terraform-AWS/assets/60320258/7dd96f57-91ca-435f-a660-3a83ca541563)
![Untitled (37)](https://github.com/shradha810/Terraform-AWS/assets/60320258/96890dae-ee8a-46fe-9b1c-4f2ee38c0bed)
![Untitled (38)](https://github.com/shradha810/Terraform-AWS/assets/60320258/8c939f6d-a766-45a3-b221-42c5ff1985f1)
![Untitled (39)](https://github.com/shradha810/Terraform-AWS/assets/60320258/c68dea29-d156-4b25-a309-6b812bb883ba)
![Untitled (40)](https://github.com/shradha810/Terraform-AWS/assets/60320258/ee06e047-8c54-46d4-94ed-0f894478dbf5)


# Clean Up
To destroy the infrastructure and resources created by Terraform, run:
```
terraform destroy -auto-approve
```

# Important Notes
- Ensure that your AWS credentials are properly configured on your local machine.
- Review the variable values and adjust them based on your requirements before applying the Terraform configuration.
- Exercise caution when destroying resources, as it will permanently delete them.
