output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "pub_subnet_1a_id" {
  value = aws_subnet.main_public_subnet_1a.id
}

output "pub_subnet_1c_id" {
  value = aws_subnet.main_public_subnet_1c.id
}

output "pri_subnet_1a_id" {
  value = aws_subnet.main_private_subnet_1a.id
}

output "pri_subnet_1c_id" {
  value = aws_subnet.main_private_subnet_1c.id
}
