resource "aws_key_pair" "key" {
  public_key = "${var.ssh_key}"

  tags = {
    Name = "Key_pair_infra"
    Terraform=true,
    Project="My_notebook"
    Owner="${var.owner}"
  }
}
