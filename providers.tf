provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      "worload" = "foundation"
    }
  }
}

provider "tls" {

}