#Database Subnet Group
resource "aws_db_subnet_group" "db-subnetgroup" {
  name       = "${var.app}-db-subnet-group"
  subnet_ids = [var.db-subnets]

  tags = {
    Name = "${var.app}-db-subnet-group"
  }
}

#DataBase MySql
resource "aws_db_instance" "db" {
  engine                 = var.engine
  db_name                = var.db-name
  multi_az               = false
  username               = var.username
  password               = var.password
  instance_class         = var.instance-class
  allocated_storage      = var.allocated-storage
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnetgroup.id
  skip_final_snapshot  = true
}

#DataBase Security Group
resource "aws_security_group" "rds" {
  name   = "${var.app}-rds-sg"
  vpc_id = var.vpc

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.rds-access.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-rds-sg"
  }
}

#DataBase Access Security Group
resource "aws_security_group" "rds-access" {
  name   = "${var.app}-rds-access-sg"
  vpc_id = var.vpc

  tags = {
    Name = "${var.app}-rds-access-sg"
  }
  }
