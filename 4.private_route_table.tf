resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gateway.id
  }

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "Private_route_table_association" {
  count          = 3
  subnet_id      = aws_subnet.eks_private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id

}
