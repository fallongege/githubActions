data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["DefaultVpc"]
  }
}

data "aws_subnet" "targetsubnet" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["DefaultSubnet1"]
  }
}

data "aws_security_group" "targetSg" {
  filter {
    name   = "tag:Name"
    values = ["ssh-https-http-default-vpc"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

}

resource "aws_instance" "targetEc2" {
  ami             = "ami-0715c1897453cabd1"
  instance_type   = "t2.small"
  subnet_id       = data.aws_subnet.targetsubnet.id
  security_groups = [data.aws_security_group.targetSg.id]
}