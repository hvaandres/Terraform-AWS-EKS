# # Define provider
# provider "aws" {
#   region     = "us-east-1"
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
# }

# Get the VPC ID from the EC2 instance
output "ec2_vpc_id" {
  value = "vpc-020b6c72d5b0aa687"
}

# Get the data source to retrieve the VPC ID
data "aws_vpc" "ec2_vpc" {
  id = "i-02c51e60bc59356d6"
}


# Use the same VPC from
resource "aws_vpc" "rds" {
  cidr_block = data.aws_vpc.ec2_vpc.cidr_block

  tags = {
    Name = "rds_vpc"
    Environment = "production"
  }
}


# Create subnets in 2 availability zones
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet_a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.rds.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet_b"
  }
}

# Create a subnet group for RDS instances
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds_subnet_group"
  subnet_ids  = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  description = "Subnets available for RDS instances"

  tags = {
    Name = "rds_subnet_group"
  }
}

# Create a security group for the RDS instance
resource "aws_security_group" "database" {
  name_prefix = "nctutorials-database"
  description = "Security group for nctutorials database"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a PostgreSQL DB instance
resource "aws_db_instance" "nctutorials" {
  engine               = "postgres"
  engine_version       = "12.8"
  instance_class       = "db.t2.micro"
  name                 = "nctutorials"
  username             = "postgres"
  password             = "admin123"
  allocated_storage    = 20
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true

  # Use the existing VPC security group
  vpc_security_group_ids = [aws_security_group.database.id]

  # Define the database name
  tags = {
    Name = "nc_tutorial_db"
  }
}

# Print the DB identifier and endpoint
output "db_identifier" {
  value = aws_db_instance.nctutorials.id
}

output "db_endpoint" {
  value = aws_db_instance.nctutorials.endpoint
}

output "db_port" {
  value = aws_db_instance.nctutorials.port
}