resource "aws_vpc" "db" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true # RDS will not work without you enabling dns settings for hostnames and support.
  enable_dns_support   = true
  tags = {
    Name = "db"
  }
}

# Subnets

resource "aws_subnet" "db-subnet01" {
  vpc_id            = aws_vpc.db.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "db"
  }
}

resource "aws_subnet" "db-subnet02" {
  vpc_id            = aws_vpc.db.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "db"
  }
}


resource "aws_subnet" "db-subnet03" {
  vpc_id            = aws_vpc.db.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "db"
  }
}


# Subnet groups, RDS will require this, whenever its being set up.
resource "aws_db_subnet_group" "db-subnet-group" {
  name = "db-subnet-group"
  subnet_ids = [
    aws_subnet.db-subnet01.id,
    aws_subnet.db-subnet02.id,
    aws_subnet.db-subnet03.id
  ]
  tags = {
    Name = "db-subnet-group"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "db-igw" {
  vpc_id = aws_vpc.db.id

  tags = {
    Name = "db"
  }
}


# Route table
resource "aws_route_table" "db-rt" {
  vpc_id = aws_vpc.db.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.db-igw.id
  }

  tags = {
    Name = "db"
  }
}

# Route Table Associations fort my subnets to the route table
resource "aws_route_table_association" "db-rta-1" {
  subnet_id      = aws_subnet.db-subnet01.id
  route_table_id = aws_route_table.db-rt.id
}

resource "aws_route_table_association" "db-rta-2" {
  subnet_id      = aws_subnet.db-subnet02.id
  route_table_id = aws_route_table.db-rt.id
}

resource "aws_route_table_association" "db-rta-3" {
  subnet_id      = aws_subnet.db-subnet03.id
  route_table_id = aws_route_table.db-rt.id
}

