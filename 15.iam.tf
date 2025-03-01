
# IAM Instance Profile for EC2 Access
#data "aws_iam_instance_profile" "s3_access_profile" {
#  name = "eks-role-bastion" # Replace with the actual name of your IAM instance profile
#}
data "aws_iam_instance_profile" "s3_access_profile" {
  name = "eks-bastion"  # Ensure the exact name
}

