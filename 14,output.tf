output "Bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint

}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
