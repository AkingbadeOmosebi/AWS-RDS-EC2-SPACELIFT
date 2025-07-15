resource "aws_instance" "ec2-mssql" {
  ami                    = "ami-0a87a69d69fa289be" # eu-central-1 frankfurt
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.db-subnet01.id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  key_name               = var.existing_key_pair_name
}