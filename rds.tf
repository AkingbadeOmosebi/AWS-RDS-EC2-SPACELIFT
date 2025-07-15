
# RDS mssql instance, original registry docs says you should add "db_name", but keep in mind that mssql doesnt allow you to do that, atleast this was the issues i stumbled into several times and wondered why.

resource "aws_db_instance" "mssql" {
  identifier           = "my-db"
  allocated_storage    = 20
  engine               = "sqlserver-ex"
  engine_version       = "15.00.4073.23.v1"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.sqlserver-ex-15.0"
  skip_final_snapshot  = true
  publicly_accessible = true

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.db-sg.id]

}
