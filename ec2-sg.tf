# Security group
resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "security group for db mssql"
  vpc_id      = aws_vpc.db.id


  # Incase i want to ssh later
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  # For https access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https access"
  }

  # For future possible web apps developments
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  # This one is required for PostgreSql port, beacuse i would likke to install postgresql on the ec2
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] 
    description = " PostgreSql port"
  }

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

