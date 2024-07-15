resource "null_resource" "install_kubeadm" {

  provisioner "file" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    source      = var.install_kubeadm.source
    destination = var.install_kubeadm.destination
  }

  provisioner "remote-exec" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    inline = [ "chmod +x ${var.install_kubeadm.destination}" ,
    "sudo ${var.install_kubeadm.destination}" 
    ]
  }
}

resource "null_resource" "install_master_node" {

  provisioner "file" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    source      = var.install_master_node.source
    destination = var.install_master_node.destination
  }

  provisioner "remote-exec" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    inline = [ "chmod +x ${var.install_master_node.destination}" ,
    "sudo ${var.install_master_node.destination}"
    ]
  }
  depends_on = [ null_resource.install_kubeadm ]
}