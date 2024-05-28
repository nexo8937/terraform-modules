output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "The certificate authority data for the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

#output "token" {
#  description = "The authentication token for the EKS cluster."
#  value       = aws_eks_cluster_auth.eks_cluster.token
#}
