output "ec2_1a_id" {
  value = aws_instance.main_ec2_1a.id
}

output "sg_ec2_id" {
  value = aws_security_group.main_sg_ec2.id
}
