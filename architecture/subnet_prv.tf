resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.My_notebook_vpc.id}"
  availability_zone = "${var.availability_zone}b"

  cidr_block = "${var.cidr_block_pr}"

  tags = {
    Name = "private_subnet_My_notebook"
    Terraform=true
    Project="My_notebook"
    Owner="${var.owner}"
  }
}