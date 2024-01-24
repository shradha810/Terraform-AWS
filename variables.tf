variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "subnet1_cidr" {
  default = "10.0.0.0/24"
}
variable "subnet1_az" {
  default = "us-east-1a"
}
variable "subnet2_cidr" {
  default = "10.0.1.0/24"
}
variable "subnet2_az" {
  default = "us-east-1b"
}
variable "route_table_cidr" {
  default = "0.0.0.0/0"
}

variable "s3_source" {
  default = "C:/Users/Admin/Desktop/Devops/Terraform/images/hello.jpg"
}
variable "s3_source1" {
  default = "C:/Users/Admin/Desktop/Devops/Terraform/images/welcome.jpg"
}

variable "security_group_name" {
  default = "sg"
}
variable "ec2_1_ami" {
  default = "ami-0c7217cdde317cfec"
}
variable "ec2_1_instance_type" {
  default = "t2.micro"
}
variable "ec2_1_user_file" {
  default = "C:/Users/Admin/Desktop/Devops/Terraform/user_data_1.sh"
}

variable "ec2_2_ami" {
  default = "ami-0c7217cdde317cfec"
}
variable "ec2_2_instance_type" {
  default = "t2.micro"
}
variable "ec2_2_user_file" {
  default = "C:/Users/Admin/Desktop/Devops/Terraform/user_data_2.sh"
}

variable "lb_name" {
  default = "ALB"
}
variable "load_balancer_type" {
  default = "application"
}
variable "lb_listener_type" {
  default = "forward"
}