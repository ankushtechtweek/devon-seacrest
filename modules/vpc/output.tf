output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_name" {
  value = "${aws_vpc.vpc.arn}"

}
output "public_subnets" {
  value = aws_subnet.public-subnets.*.id
}
output "public_subnet_0" {
  value = aws_subnet.public-subnets.0.id
}

output "public_subnet_1" {
  value = aws_subnet.public-subnets.1.id
}

output "app_subnets" {
  value = aws_subnet.private-subnets.*.id
}
output "app_subnet_0" {
  value = aws_subnet.private-subnets.0.id
}

output "app_subnet_1" {
  value = aws_subnet.private-subnets.1.id
}

output "database-subnets" {
  value = aws_subnet.database-subnets.*.id
}
output "database_subnet_0" {
  value = aws_subnet.database-subnets.0.id
}

output "database_subnet_1" {
  value = aws_subnet.database-subnets.1.id
}


output "app_route_table" {
  value = aws_route_table.app.id
}

output "public_route_table" {
  value = aws_route_table.public.id
}

output "database_route_table" {
  value = aws_route_table.database.id
}
