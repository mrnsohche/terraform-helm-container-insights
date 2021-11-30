provider "helm" {
  kubernetes {
    host                   = "https://XXXXXXXXXXXXXXXXXXXXXXX.sk1.ap-southeast-2.eks.amazonaws.com"
    cluster_ca_certificate = "QAZXSWSXCDEDCVFRTGBNHYUJMJKIOLP..."
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", "my-eks-cluster", "--region", "ap-southeast-2"]
      command     = "aws"
    }
  }
}

module "container-insights" {
  source  = "gooygeek/container-insights/helm"
  version = "1.0.0"

  eks_cluster_name      = "my-eks-cluster"
  eks_oidc_provider_url = "https://oidc.eks.ap-southeast-2.amazonaws.com/id/XXXXXXXXXXXXXXXXXXXXXXX"
  eks_oidc_provider_arn = "arn:aws:iam::ACCOUNTID:oidc-provider/oidc.eks.ap-southeast-2.amazonaws.com/id/XXXXXXXXXXXXXXXXXXXXXXX"
}
