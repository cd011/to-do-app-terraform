variable "VPC_CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string

  }))
  default = [
    {
      name = "my-tf-pub-sn-1"
      cidr = "10.0.11.0/24"
      az   = "us-east-1a"
    },
    {
      name = "my-tf-pub-sn-2"
      cidr = "10.0.12.0/24"
      az   = "us-east-1b"
    },
    {
      name = "my-tf-pvt-sn-1"
      cidr = "10.0.21.0/24"
      az   = "us-east-1a"
    },
    {
      name = "my-tf-pvt-sn-2"
      cidr = "10.0.22.0/24"
      az   = "us-east-1b"
    }
  ]
}