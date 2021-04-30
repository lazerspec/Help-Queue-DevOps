provider "aws" {
    shared_credentials_file = "~/.aws/credentials"
    region = "eu-west-1"
}

# Create VPC

resource "aws_vpc" "deployment-vpc" {

    cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "prod-vpc"
  }

}


resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.deployment-vpc.id
  cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
     availability_zone = "eu-west-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.deployment-vpc.id
  cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
     availability_zone = "eu-west-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.deployment-vpc.id
  cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "false" 
     availability_zone = "eu-west-1c"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "prod-igw" {
    vpc_id = aws_vpc.deployment-vpc.id
      tags = {
    Name = "prod-internet-gateway"
  }
}

resource "aws_route_table" "main-public-route-table" {
  vpc_id = aws_vpc.deployment-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }

  tags = {
    Name = "public-prod-route-table"
  }
}

resource "aws_route_table" "main-private-route-table" {
  vpc_id = aws_vpc.deployment-vpc.id

  tags = {
    Name = "private-prod-route-table"
  }
}


resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.main-public-route-table.id
}


// Associate with private subnet
resource "aws_route_table_association" "private-subnet-1-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.main-private-route-table.id
}

resource "aws_route_table_association" "private-subnet-2-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.main-private-route-table.id
}

// Security groups
resource "aws_security_group" "jenkins-sg" {
  name = "jenkins-sg"
  vpc_id = aws_vpc.deployment-vpc.id
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "jenkins-group"
  }
}

resource "aws_security_group" "api-sg" {
  name = "api-sg"
    vpc_id = aws_vpc.deployment-vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "api-group"
  }
}

resource "aws_security_group" "ui-sg" {
  name = "ui-sg"
    vpc_id = aws_vpc.deployment-vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "ui-group"
  }
}

resource "aws_security_group" "ssh-sg" {
  name = "ssh-sg"
    vpc_id = aws_vpc.deployment-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "ssh-group"
  }
}


resource "aws_security_group" "database-sg" {
  name = "database-sg"
    vpc_id = aws_vpc.deployment-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "database-group"
  }
}


// Create now the AWS instances

// Deployment VM
resource "aws_instance" "jenkins-instance" {
    ami = "ami-06fd78dc2f0b69910"
    instance_type = "t2.medium"
    key_name = "qa-amazon"
    subnet_id = aws_subnet.public-subnet-1.id
    vpc_security_group_ids = [aws_security_group.jenkins-sg.id,aws_security_group.ssh-sg.id]
    associate_public_ip_address	= true

tags = {
    Name = "jenkins-instance"
  }
}


// Main subnet group for DB
resource "aws_db_subnet_group" "database-subnet-group" {
  name       = "main-subnet-database"
  subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Name = "Database subnet group"
  }
}

// RDS instance
resource "aws_db_instance" "mysql-database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "proddb"
  username             = "${var.db-username}"
  password             = "${var.db-password}"
  port = "3306"
      db_subnet_group_name      = aws_db_subnet_group.database-subnet-group.id
  publicly_accessible    = true
  skip_final_snapshot    = true
  identifier = "prod-database"

   vpc_security_group_ids = [aws_security_group.database-sg.id,aws_security_group.ssh-sg.id]
tags = {
    Name = "database-instance"
  }
}