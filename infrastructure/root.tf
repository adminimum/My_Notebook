terraform {
}

provider "aws" {
  region                  = "${var.availability_zone}"
  alias                   = "use1"
  shared_credentials_file = "~/.aws/credentials"
}
