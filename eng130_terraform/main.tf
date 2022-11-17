

provider "aws" { 
  region = "eu-west-1"
}
resource "aws_vpc" "eng130_subhaan_terraform_vpc" {
 cidr_block = var.cidr_block
 instance_tenancy = "default"

 tags = {
   Name = "eng130_subhaan_terraform_vpc"
 }
}

resource "aws_subnet" "eng130_subhaan_public_subnet" {
  vpc_id     = aws_vpc.eng130_subhaan_terraform_vpc.id
  cidr_block = "10.0.12.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "eng130_subhaan_public_subnet"
  }
}

resource "aws_internet_gateway" "eng130_subhaan_igw" {
  vpc_id = aws_vpc.eng130_subhaan_terraform_vpc.id

  tags = {
    "Name" = "eng130_subhaan_igw"
  }
}

resource "aws_route_table" "eng130_subhaan_route_table" {
  vpc_id = aws_vpc.eng130_subhaan_terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eng130_subhaan_igw.id
  }
    tags = {
    Name = "eng130_subhaan_route_table"
  }
}


resource "aws_security_group" "eng130_subhaan_sg"{

  name = "eng130_subhaan_sg"

  description = "eng130_subhaan_sg"

  vpc_id = aws_vpc.eng130_subhaan_terraform_vpc.id



# Inbound Rules

  # SSH from anywhere

  ingress {

    description = "SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

 

  # HTTP from anywhere

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }
  egress{
    description = "All Outbound Traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    
    Name = "eng130_subhaan_terraform_app_sg"
    
    }
}

resource "aws_route_table_association" "eng130_subhaan_rt_association"{

  subnet_id = aws_subnet.eng130_subhaan_public_subnet.id

  route_table_id = aws_route_table.eng130_subhaan_route_table.id

}

resource "aws_instance" "app_instance" {
  ami = var.webapp_ami_id 
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = aws_subnet.eng130_subhaan_public_subnet.id
  vpc_security_group_ids = [aws_security_group.eng130_subhaan_sg.id]
  tags = {
      Name = var.instance_name
 }
}
#hello