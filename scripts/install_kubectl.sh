#!/bin/bash

HELPERS_DIR="$(dirname "$(realpath "$0")")/helpers"

source "$HELPERS_DIR/temp_dir_helper.sh"

if ! [ -x "$(command -v kubectl)" ]; then
  enter_temp_dir
  echo 'Installing Kubectl...'

  STABLE_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$STABLE_VERSION/bin/linux/amd64/kubectl"
  chmod 755 kubectl
  sudo chown root:root kubectl
  sudo mkdir -p '/usr/local/bin'
  sudo mv kubectl /usr/local/bin

  if [ -x "$(command -v kubectl)" ]; then
    echo 'Kubectl installed.'
  else
    echo 'Kubectl not installed.'
  fi
else
  echo 'Kubectl already installed.'
fi
