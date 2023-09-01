resource "aws_iam_role" "s3_access_role" {
  name = "s3-access-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_bucket_policy" {
  name = "s3_bucket_policy_for_IAM_user"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:Get*",
        "s3:List*",
        "s3:Delete*",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.bucket}"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "s3_access_attachment" {
  name       = "s3_access_attachment"
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
  roles      = [aws_iam_role.s3_access_role.name]
}

resource "aws_iam_user" "s3_access_user" {
  name = "s3-access-user"
}

resource "aws_iam_user_policy_attachment" "s3_access_user_attachment" {
  user       = aws_iam_user.s3_access_user.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}