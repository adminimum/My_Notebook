resource "aws_network_interface" "KuberMaster" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_kub_master}"]
  security_groups = [aws_security_group.kubernets_vm.id,
  aws_security_group.allow_ssh.id, aws_security_group.web_ports.id]
}
resource "aws_network_interface" "KuberNode" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_kub_node}"]
  security_groups = [aws_security_group.kubernets_vm.id,
  aws_security_group.allow_ssh.id, aws_security_group.web_ports.id]
}
resource "aws_network_interface" "MysqlDB" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_mysql}"]
  security_groups = [aws_security_group.allow_mysql.id,
  aws_security_group.allow_ssh.id]
}
resource "aws_network_interface" "Web_Server_Balancer" {
  subnet_id = aws_subnet.public.id
  private_ips = ["${var.ip_web_server}"]
  security_groups = [aws_security_group.web_ports.id,
  aws_security_group.allow_ssh.id]
}


