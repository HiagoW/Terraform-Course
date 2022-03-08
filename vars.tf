variable "amis" {
    type = map

    default = {
        "us-west-1" = "ami-051317f1184dd6e92"
        "us-west-2" = "ami-0892d3c7ee96c0bf7"
    }
}

variable "cdirs_acesso_remoto" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "cdirs_acesso_remoto_v6" {
    type = list
    default = ["::/0"]
}

variable "key_name" {
    default = "terraform-aws"
}

variable "aws_access_key"{
    default = "xxxx"
}

variable "aws_secret_key"{
    default = "xxxx"
}