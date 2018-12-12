resource "kubernetes_deployment" "build" {
  metadata {
    name = "build"

    labels {
      app = "build"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "build"
      }
    }

    template {
      metadata {
        labels {
          app = "build"
        }
      }

      spec {
        container {
          image = "jenkins/jenkins:lts"
          name  = "jenkins"

          env {
            name  = "JAVA_OPTS"
            value = "-Djenkins.install.runSetupWizard=false"
          }
          command = ["apt-get update", "apt-get -y install git curl openssh-client"]
        }

        container {
          image = "sonarqube:lts"
          name  = "sonar"
        }
      }
    }
  }
}

resource "kubernetes_service" "build" {
  metadata {
    name = "build"
  }

  spec {
    selector {
      app = "${kubernetes_deployment.build.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      name = "jenkins"
      port = "8080"
    }

    port {
      name = "sonar"
      port = "9000"
    }

    type = "LoadBalancer"
  }
}
