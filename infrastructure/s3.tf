resource "aws_s3_bucket" "s3" {
  bucket = "storemynotebookfiles"
  acl    = "private"
  tags = {
    Terraform="true"
    Project="My_NoteBook"
    Owner="${var.owner}"
  }
}