#------------------------
# EC2
#------------------------
resource "aws_instance" "main_ec2_1a" {
  ami           = "ami-0310b105770df9334"
  instance_type = "t2.micro"
  availability_zone = "ap-northeast-1a"
  subnet_id     = var.pub_subnets
  key_name = "First-key"
  vpc_security_group_ids = [aws_security_group.main_sg_ec2.id]
  associate_public_ip_address = "true"

  tags = {
    Name = "terraform-ec2-1a"
  }
}

#------------------------
# Security Group
#------------------------
resource "aws_security_group" "main_sg_ec2" {
  name        = "terraform-sg-ec2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terraform-sg-ec2"
  }
}

resource "aws_security_group_rule" "inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg_ec2.id
}

resource "aws_security_group_rule" "inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg_ec2.id
}

resource "aws_security_group_rule" "inbound_rails" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg_ec2.id
}

resource "aws_security_group_rule" "outbound_rails" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg_ec2.id
}
