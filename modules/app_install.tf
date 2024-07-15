resource "null_resource" "helm_chart" {

  provisioner "file" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    source      = var.helm_chart_source_and_destination_file.source
    destination = var.helm_chart_source_and_destination_file.destination
  }
  depends_on = [ null_resource.install_master_node ]
}

resource "null_resource" "helm_install" {

  provisioner "file" {
    connection {
      type        = var.connection_type
      user        = var.connection_user
      private_key = file(var.connection_private_key)
      host        = aws_instance.ec2_instance_master.public_ip
      port = var.connection_port
      timeout = var.connection_timeout
    }
    source      = var.helm_install_source_and_destination_file.source
    destination = var.helm_install_source_and_destination_file.destination
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
    inline = [ "chmod +x ${var.helm_install_source_and_destination_file.destination}" ,
    "sudo ${var.helm_install_source_and_destination_file.destination} ${var.AWS_BUCKET} ${var.AWS_ACCESS_KEY_ID} ${var.AWS_SECRET_ACCESS_KEY} ${var.REGION_NAME}"
    ]
  }
  depends_on = [ null_resource.install_master_node ]
}