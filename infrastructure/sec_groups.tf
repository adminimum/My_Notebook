resource "aws_security_group" "kubernets_vm" {
  name        = "My_notebook_kubernetes_cluster"
  description = "allows port access for kubernetes"
  vpc_id = aws_vpc.My_notebook_vpc.id

  dynamic "ingress"{
    for_each = ["6443","10250","10251","10252","2379","2380"]
    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ingress {
    from_port   = "${var.port_of_app}"
    to_port     = "${var.port_of_app}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Terraform="true",
    Project="My_Notebook"
    Owner="${var.owner}"
  }

}

resource "aws_security_group" "allow_ssh" {
  name        = "ssh-inbound"
  description = "Allows ssh access"
  vpc_id = aws_vpc.My_notebook_vpc.id 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Terraform="true",
    Project="${var.Project}"
    Owner="${var.owner}"
  }
}
resource "aws_security_group" "allow_mysql" {
  name        = "mysql-inbound"
  description = "Allows mysql access"
  vpc_id = aws_vpc.My_notebook_vpc.id 
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Terraform="true",
    Project="${var.Project}"
    Owner="${var.owner}"
  }
}

resource "aws_security_group" "web_ports" {
  name        = "My_notebook_web_server"
  description = "allows port access for http/https"
  vpc_id = aws_vpc.My_notebook_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Terraform="true",
    Project="${var.Project}"
    Owner="${var.owner}"
  }
}