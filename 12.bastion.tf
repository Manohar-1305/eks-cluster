resource "aws_instance" "bastion" {
  ami = var.ami_type
  instance_type = var.instance_type
  subnet_id = aws_subnet.eks_public_subnet.id
  key_name = "testing-dev-1"
  # iam_instance_profile = data.aws_iam_instance_profile.s3_access_profile.name
  user_data            = file("bastion.sh")
  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]
  tags = {
    Name = "bastion-host"
  }

  associate_public_ip_address = true
  
  depends_on = [aws_eks_cluster.eks_cluster]

}
