# Terraform File

Here I will go through the main.tf file and explain what each block of code does.

Once you have the file on your local machine and have set up terraform. You can Run:
1. `Terraform init`
2. `Terraform plan`
3. `Terraform apply`

---

```t
provider "aws" { 
  region = "eu-west-1"
}
```

I am declaring that I am using the cloud provider `aws` and the region `eu-west-1` which is where all our devops work should be.

---

```t

resource "aws_vpc" "eng130_subhaan_terraform_vpc" {
 cidr_block = var.cidr_block
 instance_tenancy = "default"
 
 tags = {
   Name = "eng130_subhaan_terraform_vpc"
 }
}

```

This resource tag creates the VPC and then gives it a name that I have initialised. This also uses the variables.tf file to give it the cidr_block `10.0.0.0/16`.

---

```t
resource "aws_subnet" "eng130_subhaan_public_subnet" {
  vpc_id     = aws_vpc.eng130_subhaan_terraform_vpc.id
  cidr_block = "10.0.12.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "eng130_subhaan_public_subnet"
  }
}
```

Here I am making the public subnet. I provide it with the VPC ID and provide it with the location and the `new` public CIDR block. 


---

```t
resource "aws_internet_gateway" "eng130_subhaan_igw" {
  vpc_id = aws_vpc.eng130_subhaan_terraform_vpc.id

  tags = {
    "Name" = "eng130_subhaan_igw"
  }
}

```

---

```t
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
```


---


```t

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

```

---

```t
resource "aws_route_table_association" "eng130_subhaan_rt_association"{

  subnet_id = aws_subnet.eng130_subhaan_public_subnet.id

  route_table_id = aws_route_table.eng130_subhaan_route_table.id

}
```
---

```t
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
```

