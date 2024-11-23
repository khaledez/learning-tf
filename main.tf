resource "aws_key_pair" "tf" {
  key_name   = "terraform_key"
  public_key = file("./tf_key_pair")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.tf.key_name
  vpc_security_group_ids      = [aws_security_group.ssh.id, aws_security_group.web.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  user_data_base64            = base64encode(file("./cloud-init.sh"))

  lifecycle {
    ignore_changes = [user_data_base64]
  }

  tags = {
    Env = "production"
  }
}
