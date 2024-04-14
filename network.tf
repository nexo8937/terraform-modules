#NETWORK

#data
data "aws_availability_zones" "working" {}

#VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.app}-vpc"
  }
}

#----------------SUBNETS----------------

#Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_ciders)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_ciders, count.index)
  availability_zone       = data.aws_availability_zones.working.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.app}-public-subnet-${count.index + 1}"
  }
}

#Private Subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_ciders)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_subnet_ciders, count.index)
  availability_zone       = data.aws_availability_zones.working.names[count.index]
  tags = {
    "Name" = "${var.app}-private-subnet-${count.index + 1}"
  }
}


#----------------GATEWAYS & ELASTIC IPS----------------

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app}-intenet-gateway"
  }
}

#Elastic IPs
resource "aws_eip" "elastic-ip" {
  count = length(var.private_subnet_ciders)
  tags = {
    Name = "${var.app}-elastic-ip-${count.index + 1}"
  }
}

#NAT gateways
resource "aws_nat_gateway" "nat-gw" {
  count         = length(var.private_subnet_ciders)
  allocation_id = aws_eip.elastic-ip[count.index].id
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
  tags = {
    Name = "${var.app}-nat-gateway-${count.index + 1}"
  }
}


#----------------ROUTE TABLES & ASSOCIATIONS----------------

#Route table for Public Subnets
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.app}-public-route-${count.index + 1}"
  }
}

#Route table for Private Subnets
resource "aws_route_table" "private_route" {
  count  =  length(var.private_subnet_ciders)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw[count.index].id
  }
  tags = {
    Name = "${var.app}-private-route-${count.index + 1}"
  }
}

#Add Public Subnets to route
resource "aws_route_table_association" "public_route_association" {
  count = length(aws_subnet.public_subnets[*].id)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route.id
}

#Add Private Subnets to route
resource "aws_route_table_association" "private_route_association" {
  count = length(aws_subnet.private_subnets[*].id)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route[count.index].id
}

