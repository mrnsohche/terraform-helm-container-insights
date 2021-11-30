output "iam_role_arn" {
  description = "ARN of the IAM role used by the cloudwatch agent containee"
  value       = aws_iam_role.eks_container_insights_role.arn
}
