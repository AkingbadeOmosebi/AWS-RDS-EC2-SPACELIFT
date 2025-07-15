
# RDS PostgreSql instance, original registry docs says you should add "db_name", but keep in mind that mssql doesnt allow you to do that, atleast this was the issues i stumbled into several times and wondered why.

resource "aws_db_instance" "postgresql" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.4"          # Or latest supported version in your region
  instance_class         = "db.t3.micro"   # Free Tier eligible
  username               = var.username
  password               = var.password
  db_name                = "mydb"          # PostgreSQL supports DB name at create
  parameter_group_name   = "default.postgres15"  # Check your region
  skip_final_snapshot    = true

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  publicly_accessible    = true

  tags = {
    Name = "postgresql-db"
  }
}
