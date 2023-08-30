resource "aws_s3_bucket" "s3" {
  bucket = "Store_My_NoteBook_Files"
  tags = {
    Terraform="true"
    Project="My_NoteBook"
    Owner="${var.owner}"
  }
}
resource "aws_s3_bucket_policy" "name" {
  bucket = "${aws_s3_bucket.s3.id}"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "AllowAccess",
      Effect    = "Allow",
      Principal = "*",
      Action    = ["s3:GetObject", "s3:PutObject"],
      Resource  = [
        "${aws_s3_bucket.s3.arn}/*",
      ],
    }],
  })
}
resource "aws_s3_bucket_acl" "example" {
  bucket = "${aws_s3_bucket.s3.id}"
  acl    = "private"
}
