#!/bin/bash

HELPERS_DIR="$(dirname "$(realpath "$0")")/helpers"

source "$HELPERS_DIR/temp_dir_helper.sh"

if ! [ -x "$(command -v terraform)" ]; then
  enter_temp_dir
  echo 'Installing Terraform...'

  curl -Lo terraform.zip https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
  unzip terraform.zip
  sudo chown root:root terraform
  sudo mkdir -p '/usr/local/bin'
  sudo mv terraform /usr/local/bin/

  if [ -x "$(command -v terraform)" ]; then
    echo 'Terraform installed.'
  else
    echo 'Terraform not installed.'
  fi
else
  echo 'Terraform already installed.'
fi
