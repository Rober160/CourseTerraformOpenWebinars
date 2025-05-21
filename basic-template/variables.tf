variable "cird" {
    description = "CIDR VPC"  
    type = string
}

variable "ami_id" {
    description = "AMI webserver"
    type = string
}

variable "tipo_instancia" {
    description = "Tipo instancia"
    type = string
}

variable "puertos" {
    description = "Puertos webserver"
    type = list(number)
}
