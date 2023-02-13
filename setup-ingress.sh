#!/bin/bash

# do we need helm?
HELM=`which helm 2>/dev/null`
if [ -x "${HELM}" ]; then
  echo We found helm, proceeding to install ingress-nginx
else
  echo Installing helm ...
  TAG='v3.11.1'
  FILE="helm-${TAG}-linux-amd64.tar.gz"
  URL="https://get.helm.sh/${FILE}"
  if [ ! -f ${FILE} ]; then
    curl -O ${URL}
  fi
  tar xzf ${FILE}
  sudo mkdir -p /usr/local/bin
  sudo cp linux-amd64/helm /usr/local/bin
  sudo chmod 755 /usr/local/bin/helm
fi

echo Installing/Upgrading ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
