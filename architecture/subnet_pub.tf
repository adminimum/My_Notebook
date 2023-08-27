resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.My_notebook_vpc.id}"
  availability_zone = "${var.availability_zone}a"

  cidr_block = "${var.cidr_block_pub}"

  tags = {
    Name = "public_subnet_My_notebook"
    Terraform=true
    Project="My_notebook"
    Owner="${var.owner}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_subnet.public.id}"
  tags = {
    Name = "igw_My_notebook"
    Terraform=true
    Project="My_notebook"
    Owner="${var.owner}"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = "${aws_subnet.public.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
resource "aws_route_table_association" "rta" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.rt.id}"
}