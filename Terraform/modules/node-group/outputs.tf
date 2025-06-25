output "node_group_arn" {
  description = "ARN of the node group"
  value       = aws_eks_node_group.this.arn
}

output "node_group_id" {
  description = "ID of the node group"
  value       = aws_eks_node_group.this.id
}

output "node_group_status" {
  description = "Status of the node group"
  value       = aws_eks_node_group.this.status
}