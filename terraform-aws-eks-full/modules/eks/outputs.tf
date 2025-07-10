output "cluster_id" { value = aws_eks_cluster.this.id }
output "endpoint" { value = aws_eks_cluster.this.endpoint }
output "kubeconfig_certificate_authority_data" { value = aws_eks_cluster.this.certificate_authority[0].data }
