provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = "postgresql"
  }
}

resource "helm_release" "postgresql-schema" {
  name = "postgresql-instance"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "postgresql"
  namespace = kubernetes_namespace.postgresql.metadata[0].name

  set {
    name  = "global.postgresql.auth.postgresPassword"
    value = "admin"
  }

  set {
    name  = "global.postgresql.auth.database"
    value = "sonarqube"
  }

  set {
    name  = "primary.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "primary.persistence.size"
    value = "5Gi"
  }
}

resource "kubernetes_namespace" "sonarqube" {
  metadata {
    name = "sonarqube"
  }
}

resource "helm_release" "sonarqube-schema" {
  name = "sonarqube-instance"
  repository = "https://sonarsource.github.io/helm-chart-sonarqube"
  chart = "sonarqube"
  namespace = kubernetes_namespace.sonarqube.metadata[0].name

  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  set {
    name  = "jdbcOverwrite.enabled"
    value = "true"
  }

  set {
    name  = "jdbcOverwrite.jdbcUrl"
    value = "jdbc:postgresql://postgresql-instance.postgresql.svc.cluster.local:5432/sonarqube"
  }

  set {
    name  = "jdbcOverwrite.jdbcUsername"
    value = "postgres"
  }

  set {
    name  = "jdbcOverwrite.jdbcPassword"
    value = "admin"
  }

  set {
    name = "persistence.enabled"
    value = "true"
  }

  set {
    name = "persistence.size"
    value = "5Gi"
  }
}
