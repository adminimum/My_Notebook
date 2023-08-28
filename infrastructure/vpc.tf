resource "aws_vpc" "My_notebook_vpc" {

  cidr_block = "${var.cidr_block_vpc}"
  
  tags = {
    Name = "${var.owner}-vpc"
    Terraform=true
    Project="${var.Project}"
    Owner="${var.owner}"
  }
}
