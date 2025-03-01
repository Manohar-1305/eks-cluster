resource "aws_subnet" "eks_public_subnet" {
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.1.5.0/24"
  availability_zone       = element(data.aws_availability_zones.available.names, 0)
  map_public_ip_on_launch = true
  tags ={
    Name = "eks_public_subnet"
  }
}

data "aws_availability_zones" "available" {}