resource "aws_instance" "Kuber_Master" {
    ami = "ami-04e601abe3e1a910f"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private.id}"
    iam_instance_profile = "${aws_iam_instance_profile.instance_profile_access_to_s3.name}"
    vpc_security_group_ids = [aws_security_group.kubernets_vm.id,
    aws_security_group.allow_ssh.id, aws_security_group.web_ports.id]
    root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
  }
}

resource "aws_instance" "Kuber_Node" {
    ami = "ami-04e601abe3e1a910f"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private.id}"
    iam_instance_profile = "${aws_iam_instance_profile.instance_profile_access_to_s3.name}"
    vpc_security_group_ids = [aws_security_group.kubernets_vm.id,
    aws_security_group.allow_ssh.id, aws_security_group.web_ports.id]
    root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
  }
}

resource "aws_instance" "MysqlBD" {
    ami = "ami-04e601abe3e1a910f"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_mysql.id,
    aws_security_group.allow_ssh.id]
    subnet_id = "${aws_subnet.private.id}"
    iam_instance_profile = "${aws_iam_instance_profile.instance_profile_access_to_s3.name}"
    key_name = aws_key_pair.key.key_name
    root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
    }
    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_instance" "web_server" {
    ami = "ami-04e601abe3e1a910f"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web_ports.id,
    aws_security_group.allow_ssh.id]
    associate_public_ip_address = true
    subnet_id = "${aws_subnet.public.id}"
    iam_instance_profile = "${aws_iam_instance_profile.instance_profile_access_to_s3.name}"
    root_block_device {
    volume_size           = "8"
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
    }
    lifecycle {
      prevent_destroy = true
    }
}