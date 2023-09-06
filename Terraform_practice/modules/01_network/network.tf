#------------------------
# VPC
#------------------------
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform-vpc"
  }
}

#------------------------
# Public Subnet (1a,1c)
#------------------------
resource "aws_subnet" "main_public_subnet_1a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-subnet-1a"
  }
}

resource "aws_subnet" "main_public_subnet_1c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-subnet-1c"
  }
}

#------------------------
# Private Subnet (1a,1c)
#------------------------
resource "aws_subnet" "main_private_subnet_1a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-private-subnet-1a"
  }
}

resource "aws_subnet" "main_private_subnet_1c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "terraform-private-subnet-1c"
  }
}

#------------------------
# Intenet Gateway
#------------------------
resource "aws_internet_gateway" "main_ig" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-ig"
  }
}

#------------------------
# Route Table
#------------------------
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "terraform-route-table"
  }
}

# IGへのルーティング
resource "aws_route" "route_ig" {
  gateway_id    = aws_internet_gateway.main_ig.id
  route_table_id         = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.main_route_table]
}

# ルートテーブルとパブリックサブネットを関連付け
resource "aws_route_table_association" "route_pubsub_1a" {
  subnet_id      = aws_subnet.main_public_subnet_1a.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "route_pubsub_1c" {
  subnet_id      = aws_subnet.main_public_subnet_1c.id
  route_table_id = aws_route_table.main_route_table.id
}
