# terraform-helm-container-insights

<!-- markdownlint-disable -->

[![Build Status](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/terraform.yml/badge.svg)](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/terraform.yml)
[![Release](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/release.yml/badge.svg)](https://github.com/gooygeek/terraform-helm-container-insights/actions/workflows/release.yml)

<!-- markdownlint-restore -->

Deploys AWS Container Insights using helm as a terraform module.
Based on the quickstart (for fluent bit) found here:
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-quickstart.html

## Usage

For a complete example, see [examples/managed_sns](examples/managed_sns).

For automated tests of the complete example using [bats](https://github.com/bats-core/bats-core) and [Terratest](https://github.com/gruntwork-io/terratest) (which tests and deploys the example on AWS), see [test](test).

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

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 2      |
| <a name="requirement_helm"></a> [helm](#requirement_helm)                | >= 2.4.1  |

## Providers

| Name                                                | Version  |
| --------------------------------------------------- | -------- |
| <a name="provider_aws"></a> [aws](#provider_aws)    | >= 2     |
| <a name="provider_helm"></a> [helm](#provider_helm) | >= 2.4.1 |

## Resources

| Name                                                                                                                                                                                  | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_role.eks_container_insights_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                                      | resource    |
| [aws_iam_role_policy_attachment.eks_container_insights_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_iam_role_policy_attachment) | resource    |
| [helm_release.container_insights](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                                               | resource    |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition)                                                                        | data source |
| [aws_iam_policy_document.eks_container_insights_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/aws_iam_policy_document)           | data source |

## Inputs

| Name                                                                                                | Description                                                       | Type     | Default                                     | Required |
| --------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | -------- | ------------------------------------------- | :------: |
| <a name="input_aws_region"></a> [aws_region](#input_aws_region)                                     | AWS Region being deployed to.                                     | `string` | `ap-southeast-2`                            |    no    |
| <a name="input_eks_cluster_name"></a> [eks_cluster_name](#input_eks_cluster_name)                   | The name of the EKS cluster.                                      | `string` | N/A                                         |   yes    |
| <a name="input_iam_role_name"></a> [iam_role_name](#input_iam_role_name)                            | The name of the IAM role for the cloudwatch agent serviceaccount. | `string` | `eks-container-insights-role`               |    no    |
| <a name="input_cloudwatch_agent_image"></a> [cloudwatch_agent_image](#input_cloudwatch_agent_image) | The image and tag to use for the cloudwatch agent container.      | `string` | `amazon/cloudwatch-agent:1.247348.0b251302` |    no    |
| <a name="input_fluentbit_image"></a> [fluentbit_image](#input_fluentbit_image)                      | The image and tag to use for the fluentbit container.             | `string` | `amazon/aws-for-fluent-bit:2.10.0`          |    no    |
| <a name="input_eks_oidc_provider_url"></a> [eks_oidc_provider_url](#input_eks_oidc_provider_url)    | URL of the OIDC identity provider associated with the cluster.    | `string` | N/A                                         |   yes    |
| <a name="input_eks_oidc_provider_arn"></a> [eks_oidc_provider_arn](#input_eks_oidc_provider_arn)    | ARN of the OIDC identity provider associated with the cluster.    | `string` | N/A                                         |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                       | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).                 | `string` | `` | no                                     |

## Outputs

| Name                                                                                                  | Description                                                     |
| ----------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| <a name="output_cwagent_iam_role_arn"></a> [cwagent_iam_role_arn](#output_cwagent_iam_role_arn)       | The ARN of the IAM role used by the cloudwatch agent container. |
| <a name="output_fluentbit_iam_role_arn"></a> [fluentbit_iam_role_arn](#output_fluentbit_iam_role_arn) | The ARN of the IAM role used by the fluentbit container.        |

## License

This library is licensed under the MIT License. See the LICENSE file.
