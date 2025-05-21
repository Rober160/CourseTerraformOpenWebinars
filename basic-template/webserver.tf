data "aws_availability_zones" "az" {
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["303888194707"]

  //buscamos entre las ami públicas
  filter {
    name = "name"
    values = ["ubuntu-2204-standard-1713549884-public"]
  }
}

resource "aws_instance" "webserver" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.tipo_instancia
  user_data = file("C:/Users/r.negretega_vitaly/Desktop/TerraformWebinars/basic-template/scripts/userdata.sh")

  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_webserver.id]
  associate_public_ip_address = true
}
