resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.My_notebook_vpc.id}"
  availability_zone = "${var.availability_zone}a"

  cidr_block = "${var.cidr_block_pub}"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_My_notebook"
    Terraform=true
    Project="My_notebook"
    Owner="${var.owner}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.My_notebook_vpc.id}"
  tags = {
    Name = "igw_My_notebook"
    Terraform=true
    Project="My_notebook"
    Owner="${var.owner}"
  }
}
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public.id}"
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name        = "nat"
  }
}
resource "aws_route_table" "rt_pub" {
  vpc_id = "${aws_vpc.My_notebook_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
resource "aws_route_table" "rt_pr" {
  vpc_id = "${aws_vpc.My_notebook_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }
}
resource "aws_route_table_association" "rta" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.rt_pub.id}"
}
resource "aws_route_table_association" "rta_pr" {
    subnet_id = "${aws_subnet.private.id}"
    route_table_id = "${aws_route_table.rt_pr.id}"
}