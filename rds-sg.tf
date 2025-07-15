# Security group
resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "security group for db mssql"
  vpc_id      = aws_vpc.db.id


  # This one is required for mssql port, beacuse i would likke to interact with AWS RDS from my local machine.
  ingress {
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # I willl open this one for my ip only, as i want to interact with AWS RDS from my local machine.
    description = "MsSQL port"
  }

  # For security group rules, to allow all outbounds
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All necessary outgoing orr outbound traffic"
  }

  tags = {
    Name = "db"
  }
}

