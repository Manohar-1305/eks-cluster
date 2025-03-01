resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags ={
    Name = "eks-igw"
  }
}
