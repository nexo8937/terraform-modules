output "kubeconfig" {
  description = "Kubeconfig for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.kubeconfig
}
