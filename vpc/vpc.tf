
/*-------------vpc-------------*/

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, {
    "Name"                                          = "${var.env}-main",
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared",
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
  tags = merge(var.tags, {
    "Name"                                          = "${var.env}-public",
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared",
  })
}

/*-------------private subnets-------------*/

resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, count.index + var.az_count)
  availability_zone = data.aws_availability_zones.az_zones.names[count.index]
  tags = merge(var.tags, {
    "Name"                                          = "${var.env}-private",
    "kubernetes.io/cluster/${var.eks_name}-cluster" = "shared",
  })
}

/*-------------internet gateway-------------*/

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(var.tags, {
    "Name" = "${var.env}-igw"
  })
}

/*-------------elastic IP address-------------*/

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"
#   tags = merge(var.tags, {
#     "Name" = "${var.env}-nat-ip"
#   })
# }

/*-------------NAT Gateway-------------*/

# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public[0].id
#   depends_on    = [aws_internet_gateway.this]

#   tags = merge(var.tags, {
#     "Name" = "${var.env}-nat-ip"
#   })
# }

/*-------------route table-------------*/

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge(var.tags, {
    "Name" = "${var.env}-route-public"
  })
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.this.id
#   }
#   tags = merge(var.tags, {
#     "Name" = "${var.env}-route-private"
#   })
# }

# resource "aws_route_table_association" "private" {
#   route_table_id = aws_route_table.private.id
#   subnet_id      = aws_subnet.private[count.index].id
#   count          = var.az_count
# }
