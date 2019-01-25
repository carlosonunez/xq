#!/usr/bin/env bash

install_docker() {
  if ! &>/dev/null which docker 
  then
    >&2 echo "INFO: Installing Docker prior to running tests."
    apk add --no-cache docker
  fi
}
