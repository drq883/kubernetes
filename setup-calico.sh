#!/bin/sh

# We got calico from: https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml

kubectl apply -f calico.yaml
