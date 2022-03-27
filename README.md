# terraform-helm-container-insights

<!-- markdownlint-disable -->

[![Build Status](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/terraform.yml/badge.svg)](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/terraform.yml)
[![Release](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/release.yml/badge.svg)](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/release.yml)

<!-- markdownlint-restore -->

Deploys AWS Container Insights using helm as a terraform module.
Based on the quickstart (for fluent bit) found here:
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-quickstart.html

## Usage

Here's how to invoke this module in your projects:

```hcl

provider "helm" {
  kubernetes {
    host                   = <eks endpoint>
    cluster_ca_certificate = base64decode(<eks certificate authority>)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", <eks cluster name>, "--region", <aws region>]
      command     = "aws"
    }
  }
}

module "container-insights" {
  source  = "gooygeek/container-insights/helm"
  version = "x.x.x"

  eks_cluster_name = <eks cluster name>
  eks_oidc_provider_url = <eks oidc provider's url>
  eks_oidc_provider_arn = <eks oidc provider's arn>
}
```

## Examples

Here is an example of using this module:

- [`examples/complete`](https://github.com/gooygeek/terraform-helm-container-insights/tree/master/examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.8.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.eks_container_insights_cwagent_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_container_insights_fluentbit_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_container_insights_cwagent_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_container_insights_fluentbit_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.container_insights](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.eks_container_insights_cwagent_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_container_insights_fluentbit_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"ap-southeast-2"` | no |
| <a name="input_cloudwatch_agent_image"></a> [cloudwatch\_agent\_image](#input\_cloudwatch\_agent\_image) | The image and tag to use for the cloudwatch agent container | `string` | `"amazon/cloudwatch-agent:1.247348.0b251302"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | ARN of the OIDC identity provider associated with the cluster | `string` | n/a | yes |
| <a name="input_eks_oidc_provider_url"></a> [eks\_oidc\_provider\_url](#input\_eks\_oidc\_provider\_url) | URL of the OIDC identity provider associated with the cluster | `string` | n/a | yes |
| <a name="input_fluentbit_image"></a> [fluentbit\_image](#input\_fluentbit\_image) | The image and tag to use for the fluentbit container | `string` | `"amazon/aws-for-fluent-bit:2.10.0"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM role for the cloudwatch agent serviceaccount | `string` | `"eks-container-insights-role"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cwagent_iam_role_arn"></a> [cwagent\_iam\_role\_arn](#output\_cwagent\_iam\_role\_arn) | ARN of the IAM role used by the cloudwatch agent container |
| <a name="output_fluentbit_iam_role_arn"></a> [fluentbit\_iam\_role\_arn](#output\_fluentbit\_iam\_role\_arn) | ARN of the IAM role used by the fluentbit container |
<!-- END_TF_DOCS -->