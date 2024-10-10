#!/bin/bash

SCRIPTS_DIR="$(dirname "$(realpath "$0")")/scripts"

"$SCRIPTS_DIR/install_minikube.sh"
"$SCRIPTS_DIR/install_terraform.sh"
"$SCRIPTS_DIR/install_kubectl.sh"
"$SCRIPTS_DIR/install_helm.sh"

MINIKUBE_STATUS=$(minikube status --format="{{.Host}}")

if [ "$MINIKUBE_STATUS" == 'Stopped' ]; then
    echo 'Starting Minikube...'

    minikube start
fi

terraform init
