#!/bin/bash

enter_temp_dir() {
  ORIGINAL_DIR=$(pwd)
  TEMP_DIR=$(mktemp -d)

  cleanup() {
    echo 'Cleaning up...'
    rm -rf "$TEMP_DIR"
    cd "$ORIGINAL_DIR" || exit 1
  }

  trap cleanup EXIT

  cd "$TEMP_DIR" || exit 1

  echo "Moving to temp dir at: $TEMP_DIR"
}
