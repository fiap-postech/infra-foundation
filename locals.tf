locals {
  vpc = {
    name                 = "tc-vpc"
    cidr_block           = "172.30.0.0/16"
    enable_dns_hostnames = true
  }

  subnets = {
    public = {
      "Public Subnet A" : {
        cidr_block        = "172.30.1.0/24"
        availability_zone = "us-east-1a"
      },
      "Public Subnet B" : {
        cidr_block        = "172.30.2.0/24"
        availability_zone = "us-east-1b"
      },
      "Public Subnet C" : {
        cidr_block        = "172.30.3.0/24"
        availability_zone = "us-east-1c"
      }
    }

    private = {
      "Private Subnet A" : {
        cidr_block        = "172.30.4.0/24"
        availability_zone = "us-east-1a"
      },
      "Private Subnet B" : {
        cidr_block        = "172.30.5.0/24"
        availability_zone = "us-east-1b"
      },
      "Private Subnet C" : {
        cidr_block        = "172.30.6.0/24"
        availability_zone = "us-east-1c"
      }
    }
  }
}