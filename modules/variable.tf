variable "AWS_BUCKET" { default = "" }
variable "AWS_ACCESS_KEY_ID" { default = "" }
variable "AWS_SECRET_ACCESS_KEY" { default = "" }
variable "REGION_NAME" { default = "" }

# for ec2.tf and master_remote_exec.tf
variable "connection_type" { default = "ssh" }
variable "connection_user" { default = "ubuntu" }
variable "connection_private_key" { default = "" }
variable "connection_port" { default = 22 }
variable "connection_timeout" { default = "10m" }

# for ec2.tf
variable "master_instance_consts" {
  description = "master ec2 instance consts"
  type = map
  default = {
    "ami" = "ami-0705384c0b33c194c"
    "instance_type" = "t3.medium" 
    "key_name" = "public-key"
    "template_tag_name" = "EC2-Master-Instance"
    "volume_size" = 16
    "volume_type" = "gp3"
  }
}

# for master_remote_exec.tf
variable "install_kubeadm" {
  type = object({
    source = string
    destination = string
  })
  default = {
    source = "./scripts/for_kubernetes/install_kubeadm.sh"
    destination = "./install_kubeadm.sh"
  }
}
variable "install_master_node" {
  type = object({
    source = string
    destination = string
  })
  default = {
    source = "./scripts/for_kubernetes/master_install.sh"
    destination = "./master_install.sh"
  }
}

# for security_group.tf
variable "allow_internet_and_web_connection_name" { default = "allow_internet_and_web_connection" }

variable "allow_internet_and_web_connection" {
  type = list(object({
    name = string
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      name = "allow-internet"
      description = "Allow internet access"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "allow-internet2"
      description = "Allow internet access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "443"
      description = "Allow HTTPS acces"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

variable "kubernetes_ports_name" { default = "kubernetes_ports" }
variable "kubernetes_ports" {
  type = list(object({
    name = string
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      name = "ssh-acces"
      description = "Run http server"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "kubernetes_api"
      description = "kubernetes api index"
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "etcd_server_client_api"
      description = "etcd server client API"
      from_port   = 2379
      to_port     = 2380
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "kublet_api"
      description = "Self, Control plane"
      from_port   = 10250
      to_port     = 10250
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "kube_scheduler"
      description = "kube scheduler"
      from_port = 10259
      to_port = 10259
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "kube_controller_manager"
      description = "kube controller manager"
      from_port = 10257
      to_port = 10257
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      name = "service_node_port"
      description = "Kubernetes node port service for the pod"
      from_port = 32000
      to_port = 32000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# for app_install.tf
variable "helm_chart_source_and_destination_file" {
  type = object({
    source = string
    destination = string
  })
  default = {
    source = "./s3_upload"
    destination = "./s3_upload"
  }
}

variable "helm_install_source_and_destination_file" {
  type = object({
    source = string
    destination = string
  })
  default = {
    source = "./scripts/helm_install.sh"
    destination = "./helm_install.sh"
  }
}
