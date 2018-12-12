variable "tag" {}

locals {
  port = "5000"
  repo = "malferov"
  app  = "app"
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "${local.app}"

    labels {
      app = "${local.app}"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels {
        app = "${local.app}"
      }
    }

    template {
      metadata {
        labels {
          app = "${local.app}"
        }
      }

      spec {
        container {
          image = "${local.repo}/${local.app}:${var.tag}"
          name  = "${local.app}"
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "${local.app}"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.app.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      port = "${local.port}"
    }

    type = "LoadBalancer"
  }
}
