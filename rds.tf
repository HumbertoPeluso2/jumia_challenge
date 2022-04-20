
resource "aws_db_subnet_group" "rds-subnet-group" {
  name         = "database subnets"
  subnet_ids = module.vpc.private_subnets

  tags   = {
    Name = "jumia"
  }
}

resource "aws_security_group" "allow-tcp" {
  name        = "allow-tcp-on-22-1337-5432"
  description = "Allow Tcp inbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "security group db"
  }
}

resource "aws_security_group_rule" "db-security-group-rule-allow-22" {
  description              = "Allow port 22 nodes to communicate with control plane (all ports)"
  from_port                = 22
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [var.vpc_cidr_block]
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "db-security-group-rule-allow-1337" {
  description              = "Allow port 1337 nodes to communicate with control plane (all ports)"
  from_port                = 1337
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [var.vpc_cidr_block]
  to_port                  = 1337
  type                     = "ingress"
}

resource "aws_security_group_rule" "db-security-group-rule-allow-5432" {
  description              = "Allow port 1337 nodes to communicate with control plane (all ports)"
  from_port                = 5432
  protocol                 =  "tcp"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [var.vpc_cidr_block]
  to_port                  = 5432
  type                     = "ingress"
}

resource "aws_security_group_rule" "outgoing" {
  description              = "Allow all outgoing"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.allow-tcp.id
  cidr_blocks              = [var.vpc_cidr_block]
  to_port                  = 0
  type                     = "egress"
}

# RDS instance
resource "aws_db_instance" "postgres" {

  allocated_storage    = 10
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  db_name               = "jumiadb"
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  username             = "jumia"
  password             = "jumia1234"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  vpc_security_group_ids  = [aws_security_group.allow-tcp.id]
}