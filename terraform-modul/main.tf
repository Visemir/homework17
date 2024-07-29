provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}


module "ec2_with_nginx" {
  source           = "./modules/ec2_with_nginx"
  vpc_id           = aws_vpc.main_vpc.id
  list_of_open_ports = var.list_of_open_ports
}

output "instance_ip" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2_with_nginx.instance_ip
}