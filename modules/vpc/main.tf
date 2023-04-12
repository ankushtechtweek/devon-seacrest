locals {

#name_vpc  = format("%s-%s-%s", var.name, var.environment, vpc)
#name_vpc    = var.tags
}
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc.vpc_cidr
  enable_dns_support   = var.vpc.enable_dns_support
  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  instance_tenancy     = var.vpc.instance_tenancy
  tags    =  {
    Name        = "${var.name}-${var.environment}-vpc"
  }
}

##public subnets##
resource "aws_subnet" "public-subnets" {
  depends_on = [
    aws_vpc.vpc,
  ]

  vpc_id                  = aws_vpc.vpc.id
  count                   = "${length(var.vpc.public-subnets)}"
  cidr_block              = "${element(var.vpc.public-subnets, count.index)}"
  availability_zone       = "${element(var.vpc.availability_zones, count.index)}"
  map_public_ip_on_launch = var.vpc.map_public_ip_on_launch
  tags = {
    Name        = "${var.name}-${var.environment}-pub-sub-${element(var.vpc.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

##private subnet##
resource "aws_subnet" "private-subnets" {
  depends_on = [
    aws_vpc.vpc,
  ]

  vpc_id                  = aws_vpc.vpc.id
  count                   = "${length(var.vpc.private-subnets)}"
  cidr_block              = "${element(var.vpc.private-subnets, count.index)}"
  availability_zone       = "${element(var.vpc.availability_zones, count.index)}"
  map_public_ip_on_launch = var.vpc.map_public_ip_on_launch
  tags = {
    Name        = "${var.name}-${var.environment}-pri-sub-${element(var.vpc.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "database-subnets" {
  depends_on = [
    aws_vpc.vpc,
  ]

  vpc_id                  = aws_vpc.vpc.id
  count                   = "${length(var.vpc.database-subnets)}"
  cidr_block              = "${element(var.vpc.database-subnets, count.index)}"
  availability_zone       = "${element(var.vpc.availability_zones, count.index)}"
  map_public_ip_on_launch = var.vpc.map_public_ip_on_launch
  tags = {
    Name        = "${var.name}-${var.environment}-database-sub-${element(var.vpc.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

##Internet gateway##
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.name}-${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

#Elastic IP for NAT 

#NOT required in DEV env 

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

#nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = "${element(aws_subnet.public-subnets.*.id,0)}"
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name        = "${var.name}-${var.environment}-nat"
    Environment = "${var.environment}"

  }
}

##route table##

resource "aws_route_table" "app" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-${var.environment}-app-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}


resource "aws_route_table" "database" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.name}-${var.environment}-database-route-table"
    Environment = "${var.environment}"
  }
}

##routes 
resource "aws_route" "public_internet_gateway_1" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

/*

resource "aws_route" "public_internet_gateway_2" {
  route_table_id         = "${aws_route_table.app.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
  count                  = "${var.environment == "prod" ? 0 : 1}"
}

*/

resource "aws_route" "public_internet_gateway_3" {
  route_table_id         = "${aws_route_table.database.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

resource "aws_route" "nat_gateway" {
  route_table_id         = "${aws_route_table.app.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat.id
  depends_on             = [aws_nat_gateway.nat]
}

##association
resource "aws_route_table_association" "public" {
  count          = length(var.vpc.public-subnets)
  subnet_id      = "${element(aws_subnet.public-subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "database" {
  count          = length(var.vpc.database-subnets)
  subnet_id      = "${element(aws_subnet.database-subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.database.id}"
}

resource "aws_route_table_association" "app" {
  count          = length(var.vpc.private-subnets)
  subnet_id      = "${element(aws_subnet.private-subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.app.id}"
}

##security group
resource "aws_security_group" "vpc-sg" {
  name        = "${var.name}-${var.environment}-vpc-sg"
  description = "Security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags = {
    Environment = "${var.environment}"
  }
}