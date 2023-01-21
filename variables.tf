
variable "aws_region" {
  description = "The AWS region to use."
  default     = "us-east-1"
  type        = string
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role for the cloudwatch agent serviceaccount"
  type        = string
  default     = "eks-container-insights-role-che001"
}

variable "cloudwatch_agent_image" {
  description = "The image and tag to use for the cloudwatch agent container"
  type        = string
  default     = "amazon/cloudwatch-agent:1.247348.0b251302"
}

variable "fluentbit_image" {
  description = "The image and tag to use for the fluentbit container"
  type        = string
  default     = "amazon/aws-for-fluent-bit:2.10.0"
}

variable "eks_oidc_provider_url" {
  description = "URL of the OIDC identity provider associated with the cluster"
  type        = string
}

variable "eks_oidc_provider_arn" {
  description = "ARN of the OIDC identity provider associated with the cluster"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

data "aws_partition" "this" {}
