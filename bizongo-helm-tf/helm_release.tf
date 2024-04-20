# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "flask-chart" {
  name       = "flask-chart"
  repository = "https://aadirai02.github.io/bizongo-chart/"
  chart      = "flask-chart"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}

resource "helm_release" "mongo-chart" {
  name       = "mongo-chart"
  repository = "https://aadirai02.github.io/bizongo-chart/"
  chart      = "mongo-chart"

  values = [
    file("${path.module}/nginx-values.yaml")
  ]
}
