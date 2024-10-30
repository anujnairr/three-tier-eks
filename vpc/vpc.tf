
/*-------------vpc-------------*/

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, { "Name" = "${var.env}-main",
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared"
  })
}

/*-------------AZ zones-------------*/

data "aws_availability_zones" "az_zones" {
  state = "available"
}

/*-------------public subnets-------------*/

resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index)
  availability_zone = data.aws_availability_zones.az_zones.names[count.index]
  tags = {
    "Name"                                          = "${var.env}-public"
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

/*-------------private subnets-------------*/

resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index + var.az_count)
  availability_zone = data.aws_availability_zones.az_zones.names[count.index]
  tags = {
    "Name"                                          = "${var.env}-private"
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

/*-------------internet gateway-------------*/

