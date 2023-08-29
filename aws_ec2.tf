# Making EC2 instance
resource "aws_instance" "sample_web_server" {
  ami                    = "ami-09d28faae2e9e7138" # Amazon Linux 2023 ARM64
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sample_subnet.id
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  key_name               = "github_ed25519"

  user_data = <<EOF
#!/bin/sh
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
EOF

}

