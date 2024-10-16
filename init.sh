#!/bin/bash

PROJECT_DIR="$(dirname "$(realpath "$0")")"
SCRIPTS_DIR="$PROJECT_DIR/scripts"
CONFIGS_DIR="$PROJECT_DIR/configs"

"$SCRIPTS_DIR/install_minikube.sh"
"$SCRIPTS_DIR/install_terraform.sh"
"$SCRIPTS_DIR/install_kubectl.sh"
"$SCRIPTS_DIR/install_helm.sh"

MINIKUBE_STATUS=$(minikube status --format="{{.Host}}")

if [ "$MINIKUBE_STATUS" != 'Running' ]; then
  echo 'Starting Minikube...'

  minikube start
fi

if ! minikube addons list | grep 'ingress\s' | grep 'enabled' &> /dev/null; then
  echo 'Enabling Minikube ingress addon...'

  minikube addons enable ingress
fi

terraform init
terraform apply

kubectl apply -f "$CONFIGS_DIR/sonarqube-ingress.yaml"
