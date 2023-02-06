output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the Subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the Subnet"
  value       = aws_subnet.private_subnet.id
}

output "security_group_id" {
  description = "ID of the Security group"
  value       = aws_security_group.allow_tls.id
}

output "routing_table_id" {
  description = "ID of the Security group"
  value       = aws_route_table.second_rt.id
}

output "internet_gateway_id" {
  description = "ID of the Security group"
  value       = aws_internet_gateway.gw.id
}

output "route_table_association_id" {
  description = "ID of the Security group"
  value       = aws_route_table_association.public_subnet_asso.id
}

# output "aws_instance_id" {
#   description = "ID of the Instance"
#   value       = aws_instance.app_server.id
# }

