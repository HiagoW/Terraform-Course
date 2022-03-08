terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "rmerceslabs-hiago"

    workspaces {
      name = "aws-rmerceslabs-hiago"
    }
  }
}