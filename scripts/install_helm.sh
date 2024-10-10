#!/bin/bash

HELPERS_DIR="$(dirname "$(realpath "$0")")/helpers"

source "$HELPERS_DIR/temp_dir_helper.sh"

if ! [ -x "$(command -v helm)" ]; then
  enter_temp_dir
  echo 'Installing Helm...'

  curl -Lo get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  chmod 700 get_helm.sh
  sudo mkdir -p '/usr/local/bin'
  HELM_INSTALL_DIR='/usr/local/bin' ./get_helm.sh

  if [ -x "$(command -v helm)" ]; then
    echo 'Helm installed.'
  else
    echo 'Helm not installed.'
  fi
else
  echo 'Helm already installed.'
fi
