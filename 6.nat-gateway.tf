resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "eks_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.eks_public_subnet.id
  depends_on    = [aws_internet_gateway.eks_igw]
}
