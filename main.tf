terraform {
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

provider "aws" {
    alias = "us-west-1"
    region = "us-west-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_instance" "dev" {
    count = 3
    ami = var.amis["us-west-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev${count.index}"
    }
    // Vai remover o grupo default
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh.id}" ]
}

resource "aws_instance" "dev4" {
    ami = var.amis["us-west-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev4"
    }
    // Vai remover o grupo default
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh.id}" ]
    depends_on = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" {
    ami = var.amis["us-west-2"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev5"
    }
    // Vai remover o grupo default
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh.id}" ]
}

resource "aws_instance" "dev6" {
    provider = aws.us-west-1
    ami = var.amis["us-west-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev6"
    }
    // Vai remover o grupo default
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-west-1.id}" ]
    depends_on = [aws_dynamodb_table.dynamodb-homologacao]
}

resource "aws_instance" "dev7" {
    provider = aws.us-west-1
    ami = var.amis["us-west-1"]
    instance_type = "t2.micro"
    key_name = var.key_name
    tags = {
        Name = "dev7"
    }
    // Vai remover o grupo default
    vpc_security_group_ids = [ "${aws_security_group.acesso-ssh-us-west-1.id}" ]
}

resource "aws_s3_bucket" "dev4" {
  bucket = "rmerceslabs-dev4-hiago"
  acl = "private"

  tags = {
    Name        = "rmerceslabs-dev4-hiago"
  }
}

resource "aws_s3_bucket" "homologacao" {
  bucket = "rmerceslabs-homologacao-hiago"
  acl = "private"

  tags = {
    Name        = "rmerceslabs-homologacao-hiago"
  }
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = aws.us-west-1
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}