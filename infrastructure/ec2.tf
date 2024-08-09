data "aws_ami" "debian_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"]  # Official Debian images on AWS
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.debian_latest.id
  instance_type = "t3.medium"

  user_data = <<-EOF
    #!/bin/bash
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  EOF

  tags = {
    Name = "docker-compose-instance-voting-app"
    Terraform = "true"
    Environment = "dev"
    Application = "voting-app"
  }
}