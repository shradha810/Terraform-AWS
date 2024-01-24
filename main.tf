################################################################ VPC #############################################################
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet1_cidr
  availability_zone = var.subnet1_az
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet2_cidr
  availability_zone = var.subnet2_az
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RouteTableAssociation1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_route_table_association" "RouteTableAssociation2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_security_group" "SecurityGroup" {
  name        = var.security_group_name
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################ S3 #############################################################
resource "aws_s3_bucket" "S3Bucket" {
  bucket = "shradha-agarwal-terraform-project"
}

resource "aws_s3_object" "image_object1" {
  bucket = aws_s3_bucket.S3Bucket.id
  key    = "hello.jpg"
  source = var.s3_source
}

resource "aws_s3_object" "image_object2" {
  bucket = aws_s3_bucket.S3Bucket.id
  key    = "welcome.jpg"
  source = var.s3_source1
}
################################################################ EC2 #############################################################

resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "webserver_instance_profile" {
  name  = "webserver-instance-profile" 
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.ec2_role.name
}

resource "aws_instance" "webserver1" {
  ami                    = var.ec2_1_ami
  instance_type          = var.ec2_1_instance_type
  vpc_security_group_ids = [aws_security_group.SecurityGroup.id]
  subnet_id              = aws_subnet.subnet1.id
  iam_instance_profile   = aws_iam_instance_profile.webserver_instance_profile.name
  user_data              = base64encode(file(var.ec2_1_user_file))
}

resource "aws_instance" "webserver2" {
  ami                    = var.ec2_2_ami
  instance_type          = var.ec2_2_instance_type
  vpc_security_group_ids = [aws_security_group.SecurityGroup.id]
  subnet_id              = aws_subnet.subnet2.id
  iam_instance_profile   = aws_iam_instance_profile.webserver_instance_profile.name
  user_data              = base64encode(file(var.ec2_2_user_file))
}

################################################################ ALB #############################################################
resource "aws_lb" "ApplicationLB" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.SecurityGroup.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "TargetGroup" {
  name     = "TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachments" {
  for_each = {
    webserver1 = aws_instance.webserver1.id,
    webserver2 = aws_instance.webserver2.id
  }
  target_group_arn = aws_lb_target_group.TargetGroup.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_listener" "AlbListener" {
  load_balancer_arn = aws_lb.ApplicationLB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.lb_listener_type
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}