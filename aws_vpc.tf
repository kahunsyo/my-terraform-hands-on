# Making VPC
resource "aws_vpc" "sample_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# Making Public subnet
resource "aws_subnet" "sample_subnet" {
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
}

# Making Internet Gateway
resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id
}

# Making Root Table
resource "aws_route_table" "sample_rtb" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }
}

# Combining Root Table to Subnet
resource "aws_route_table_association" "sample_rt_assoc" {
  subnet_id      = aws_subnet.sample_subnet.id
  route_table_id = aws_route_table.sample_rtb.id
}

# Making Security Group
resource "aws_security_group" "sample_sg" {
  name   = "sample-sg"
  vpc_id = aws_vpc.sample_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}