output "cwagent_iam_role_arn" {
  description = "ARN of the IAM role used by the cloudwatch agent container"
  value       = aws_iam_role.eks_container_insights_cwagent_role.arn
}

output "fluentbit_iam_role_arn" {
  description = "ARN of the IAM role used by the fluentbit container"
  value       = aws_iam_role.eks_container_insights_fluentbit_role.arn
}
