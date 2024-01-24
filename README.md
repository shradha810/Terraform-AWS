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
git clone <repository_url>
cd <repository_directory>
terraform init
terraform apply

# Output
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/3c668c01-97a2-4014-9756-2dfb009c19ec/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/147447bb-3858-4caf-9040-cb653cde3edf/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/5e61f95c-7552-434e-bd5a-3848dff74554/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/785af6b9-d42d-469b-81a6-c9b460e6b39b/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/d1bedc87-4321-4913-a1cd-48deeb1ca55a/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/cea7c5c1-a24a-4e11-b8aa-9cfc20cb7ded/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/db38187c-f72f-4db9-8842-6d51d3c43dd6/Untitled.png)
![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b38ad723-1a0c-411d-a45f-8543b6c8927f/44c8e2a9-b4fa-46c9-8a28-e3f073ac0c87/Untitled.png)

# Clean Up
To destroy the infrastructure and resources created by Terraform, run:
terraform destroy -auto-approve

# Important Notes
- Ensure that your AWS credentials are properly configured on your local machine.
- Review the variable values and adjust them based on your requirements before applying the Terraform configuration.
- Exercise caution when destroying resources, as it will permanently delete them.
