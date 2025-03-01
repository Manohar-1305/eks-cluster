# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "Private_EKS_Cluster"
  role_arn = aws_iam_role.eks_master_role.arn
  version  = "1.30"  # Specify EKS version 1.29

  vpc_config {
    subnet_ids              = aws_subnet.eks_private_subnet[*].id
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.eks_sg.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
  ]
}
