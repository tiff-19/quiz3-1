resource "aws_vpc" "quiz3-vpc" {
  cidr_block            = "10.0.0.0/16"
  instance_tenancy      = "default"
  enable_dns_support    = "true"
  enable_dns_hostnames  = "true"
  enable_classiclink    = "false"

  tags = {
    Name = "quiz3-vpc"
  }
}

resource "aws_subnet" "quiz3-public-1" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.1.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1a"

  tags = {
    Name = "quiz3-public-1"
  }
}

resource "aws_subnet" "quiz3-public-2" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.2.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1b"

  tags = {
    Name = "quiz3-public-2"
  }
}

resource "aws_subnet" "quiz3-public-3" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.3.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1c"

  tags = {
    Name = "quiz3-public-3"
  }
}

resource "aws_subnet" "quiz3-private-1" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.4.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1a"

  tags = {
    Name = "quiz3-private-1"
  }
}

resource "aws_subnet" "quiz3-private-2" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.5.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1b"

  tags = {
    Name = "quiz3-private-2"
  }
}

resource "aws_subnet" "quiz3-private-3" {
  vpc_id                    = aws_vpc.quiz3-vpc.id
  cidr_block                = "10.0.6.0/24"
  map_public_ip_on_launch   = "true"
  availability_zone         = "ap-southeast-1c"

  tags = {
    Name = "quiz3-private-3"
  }
}

resource "aws_internet_gateway" "quiz3-gw" {
  vpc_id = aws_vpc.quiz3-vpc.id

  tags = {
    Name = "quiz3-gw"
  }
}

resource "aws_route_table" "quiz3-rt" {
  vpc_id = aws_vpc.quiz3-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.quiz3-gw.id
  }

  tags = {
    Name = "quiz3-rt"
  }
}

# resource "aws_main_route_table_association" "quiz3-public-rta1" {
#   subnet_id      = aws_subnet.quiz3-public-1.id
#   route_table_id = aws_route_table.quiz3-rt.id
# }

# resource "aws_main_route_table_association" "quiz3-public-rta2" {
#   subnet_id      = aws_subnet.quiz3-public-2.id
#   route_table_id = aws_route_table.quiz3-rt.id
# }

# resource "aws_main_route_table_association" "quiz3-public-rta3" {
#   subnet_id      = aws_subnet.quiz3-public-3.id
#   route_table_id = aws_route_table.quiz3-rt.id
# }