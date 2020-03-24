#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "eks-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = map(
    "Name", "eks-vpc",
    "kubernetes.io/cluster/${var.cluster_name}", "shared",
  )
}

resource "aws_subnet" "eks-public-subnets" {
  count = 3

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.eks-vpc.id

  tags = map(
    "Name", "eks-public-subnets${count.index}",
    "kubernetes.io/cluster/${var.cluster_name}", "shared",
  )
}

resource "aws_subnet" "eks-private-subnets" {
  count = 3

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${format("%d", count.index + 100)}.0/24"
  vpc_id            = aws_vpc.eks-vpc.id

  tags = map(
    "Name", "eks-private-subnets${count.index}",
    "kubernetes.io/cluster/${var.cluster_name}", "shared",
  )
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_route_table" "eks-public-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
}

resource "aws_route_table_association" "eks-public-rt-asso" {
  count = 3

  subnet_id      = aws_subnet.eks-public-subnets[count.index].id
  route_table_id = aws_route_table.eks-public-rt.id
}

resource "aws_eip" "eks-nat-eip" {
  count = 3

  vpc        = true
  depends_on = [aws_internet_gateway.eks-igw]
}


resource "aws_nat_gateway" "eks-nat-gw" {
  count = 3

  allocation_id = aws_eip.eks-nat-eip[count.index].id
  subnet_id     = aws_subnet.eks-public-subnets[count.index].id
  depends_on    = [aws_eip.eks-nat-eip]
}


resource "aws_route_table" "eks-private-rt" {
  count = 3

  vpc_id     = aws_vpc.eks-vpc.id
  depends_on = [aws_nat_gateway.eks-nat-gw]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-nat-gw[count.index].id
  }
  tags = {
    Name = "eks-private-rt-${count.index}"
  }
}

resource "aws_route_table_association" "eks-private-rt-asso" {
  count = 3
  
  subnet_id      = aws_subnet.eks-private-subnets[count.index].id
  route_table_id = aws_route_table.eks-private-rt[count.index].id
}