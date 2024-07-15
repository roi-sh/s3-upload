resource "aws_instance" "ec2_instance_master" {
  ami           = var.master_instance_consts.ami  
  instance_type = var.master_instance_consts.instance_type
  key_name      = var.master_instance_consts.key_name
  tags = {
    Name = "${var.master_instance_consts.template_tag_name}"
  }
  root_block_device {
    volume_size = var.master_instance_consts.volume_size
    volume_type = var.master_instance_consts.volume_type
  }
  vpc_security_group_ids = [
    aws_security_group.allow_internet_and_web_connection.id,
    aws_security_group.kubernetes_ports.id
  ]
  depends_on = [ aws_s3_bucket_policy.policy ]
}