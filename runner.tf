resource "aws_instance" "runner" {
  ami                         = "ami-0015a39e4b7c0966f"
  subnet_id                   = module.vpc.public_subnets[0]
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.cluster.id]
  key_name                    = "jumia_devops"

  tags = {
    Name = "jumia"
  }

}

resource "null_resource" "install-runner-requirements"{

   provisioner "remote-exec" {
        connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file(var.private_key_path)
        host        = aws_instance.runner.public_ip
        }
    inline = ["echo Teste"]
    }
  }
