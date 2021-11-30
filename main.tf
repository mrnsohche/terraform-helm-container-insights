
#   _____          __  __
#  |_   _|   /\   |  \/  |
#    | |    /  \  | \  / |
#    | |   / /\ \ | |\/| |
#   _| |_ / ____ \| |  | |
#  |_____/_/    \_\_|  |_|

data "aws_iam_policy_document" "eks_container_insights_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks_oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:amazon-cloudwatch:cloudwatch-agent"]
    }

    principals {
      identifiers = [var.eks_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_container_insights_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_container_insights_assume_role_policy.json
  name               = var.iam_role_name

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_container_insights_policy_attachment" {
  role       = aws_iam_role.eks_container_insights_role.name
  policy_arn = "arn:${data.aws_partition.this.partition}:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#   _    _      _
#  | |  | |    | |
#  | |__| | ___| |_ __ ___
#  |  __  |/ _ \ | '_ ` _ \
#  | |  | |  __/ | | | | | |
#  |_|  |_|\___|_|_| |_| |_|

resource "helm_release" "container_insights" {
  depends_on = [aws_iam_role.eks_container_insights_role]

  name      = "container-insights"
  chart     = "${path.module}/charts/container-insights"
  namespace = "amazon-cloudwatch"

  set {
    name  = "region_name"
    value = var.aws_region
  }

  set {
    name  = "cluster_name"
    value = var.eks_cluster_name
  }

  set {
    name  = "http_server_toggle"
    value = "On"
  }

  set {
    name  = "http_server_port"
    value = "2020"
  }

  set {
    name  = "read_from_head"
    value = "Off"
  }

  set {
    name  = "read_from_tail"
    value = "On"
  }

  set {
    name  = "container_insights_iam_role_arn"
    value = aws_iam_role.eks_container_insights_role.arn
  }

  set {
    name  = "cloudwatch_agent_image"
    value = var.cloudwatch_agent_image
  }

  set {
    name  = "fluentbit_image"
    value = var.fluentbit_image
  }
}
