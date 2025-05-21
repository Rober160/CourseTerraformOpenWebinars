resource "aws_vpc" "vpc" {
  cidr_block = var.cird
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "openwebinars"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "GW"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/16"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "sg_webserver" {
  name = "Permitir SSH"
  description = "Entrada SSH"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.puertos
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
