resource "aws_network_interface" "KuberMaster" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_kub_master}"]
  
  attachment {
    device_index = 0
    instance = aws_instance.Kuber_Master.id
  }
}
resource "aws_network_interface" "KuberNode" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_kub_node}"]

  attachment {
    device_index = 1
    instance = aws_instance.Kuber_Node.id
  }
}
resource "aws_network_interface" "MysqlDB" {
  subnet_id = aws_subnet.private.id
  private_ips = ["${var.ip_mysql}"]
  
  attachment {
    device_index = 2
    instance = aws_instance.MysqlBD.id
  }
}
resource "aws_network_interface" "Web_Server_Balancer" {
  subnet_id = aws_subnet.public.id
  private_ips = ["${var.ip_web_server}"]
  
  attachment {
    device_index = 3
    instance = aws_instance.web_server.id
  }
}


