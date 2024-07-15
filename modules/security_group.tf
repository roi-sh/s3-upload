resource "aws_security_group" "allow_internet_and_web_connection" {
  name = var.allow_internet_and_web_connection_name

  dynamic "ingress" {
    for_each = var.allow_internet_and_web_connection
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.allow_internet_and_web_connection
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks 
    }
  }
}

resource "aws_security_group" "kubernetes_ports" {
   name = var.kubernetes_ports_name

  dynamic "ingress" {
    for_each = var.kubernetes_ports
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  dynamic "egress" {
    for_each = var.kubernetes_ports
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}