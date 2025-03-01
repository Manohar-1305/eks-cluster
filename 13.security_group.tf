resource "aws_security_group" "eks_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  egress {
    from_port = 0
    to_port =0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port =0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name = "bastion-sg"
  }
}