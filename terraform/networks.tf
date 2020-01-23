resource "aws_vpc" "natemate-vpc" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = false
  tags = {
    Name = "VPC_for_NateMate"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_subnet" "natemate-subnet" {
  vpc_id     = aws_vpc.natemate-vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "NateMate_subnet"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.natemate-vpc.id
  cidr_block = "10.0.100.0/24"
  tags = {
    Name = "NateMate_P1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.natemate-vpc.id
  cidr_block = "10.0.101.0/24"
  tags = {
    Name = "NateMate_P2"
  }
}

resource "aws_db_subnet_group" "natemate-rds-subnet-group" {
  name        = "natemate_db_sg"
  description = "for natemate"
  subnet_ids  = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
}


resource "aws_internet_gateway" "natemate-IG" {
  vpc_id = aws_vpc.natemate-vpc.id
  tags = {
    Name = "Gateway_for_NateMate"
  }
}

resource "aws_route_table" "natemate-route-table" {
  vpc_id = aws_vpc.natemate-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.natemate-IG.id
  }
  tags = {
    Name = "Table_for_NateMate"
  }
}

resource "aws_route_table_association" "natemate-sbn-rtb" {
  subnet_id      = aws_subnet.natemate-subnet.id
  route_table_id = aws_route_table.natemate-route-table.id
}




