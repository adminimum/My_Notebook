output "vpc_id" {
  value = aws_vpc.My_notebook_vpc.id
}
output "private_ip_KubeMaster" {
  value = aws_instance.Kuber_Master.private_ip
}
output "private_ip_KubeNode" {
  value = aws_instance.Kuber_Node.private_ip
}
output "private_ip_MysqlServer" {
  value = aws_instance.MysqlBD.private_ip
}
output "private_ip_WebServer" {
  value = aws_instance.web_server.private_ip
}
output "public_ip_WebServer" {
  value = aws_instance.web_server.public_ip
}
output "key_name" {
  value = aws_key_pair.key.key_name
}
output "s3_bucket_name" {
  value = aws_s3_bucket.s3.bucket
}
output "s3_bucket_dom_name" {
  value = aws_s3_bucket.s3.bucket_domain_name
}
output "aws_iam_s3_user" {
  value = aws_iam_user.s3_access_user.name
}