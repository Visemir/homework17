resource "aws_subnet" "main_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "main_subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "main_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main_route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}
resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "Security group for Nginx"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.list_of_open_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx_sg"
  }
}

resource "aws_instance" "nginx_instance" {
  ami           = "ami-07c8c1b18ca66bb07" 
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.main_subnet.id
  security_groups = [aws_security_group.nginx_sg.id]
  key_name      = "danit17"  
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo echo "Welcome DanIT" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "nginx_instance"
  }
}

output "instance_ip" {
  value = aws_instance.nginx_instance.public_ip
}

