#!/bin/bash

HELPERS_DIR="$(dirname "$(realpath "$0")")/helpers"

source "$HELPERS_DIR/temp_dir_helper.sh"

if ! [ -x "$(command -v minikube)" ]; then
  enter_temp_dir
  echo 'Installing Minikube...'

  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo mkdir -p '/usr/local/bin'
  sudo install minikube /usr/local/bin/

  if [ -x "$(command -v minikube)" ]; then
    echo 'Minikube installed.'
  else
    echo 'Minikube not installed.'
  fi
else
  echo 'Minikube already installed.'
fi
