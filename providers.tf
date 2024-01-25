provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      "workload" = "foundation"
    }
  }
}

provider "tls" {

}