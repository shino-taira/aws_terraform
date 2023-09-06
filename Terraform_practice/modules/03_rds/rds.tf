#------------------------
# RDS
#------------------------
resource "aws_db_instance" "main_rds" {
  allocated_storage    = 20
  db_name              = "mainrds"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "${var.db_password}"
  parameter_group_name = aws_db_parameter_group.main_parameter_group.name
  skip_final_snapshot  = true
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.main_subnet_group.id
  vpc_security_group_ids = [aws_security_group.main_sg_rds.id]

  tags = {
    Name = "terraform-rds"
  }
}

#------------------------
# Security Group
#------------------------
resource "aws_security_group" "main_sg_rds" {
  name        = "terraform-sg-rds"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "inbound_http" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main_sg_rds.id
}

#------------------------
# Subnet Group
#------------------------
resource "aws_db_subnet_group" "main_subnet_group" {
    name        = "terraform-subnet-group"
    subnet_ids  = [var.pri_subnets_1a, var.pri_subnets_1c]
    tags = {
        Name = "terraform-subnet-group"
    }
}

#------------------------
# Parameter Group
#------------------------
resource "aws_db_parameter_group" "main_parameter_group" {
    name        = "terraform-parameter-group"
    family      = "mysql8.0"
    tags = {
        Name = "terraform-parameter-group"
    }
}
