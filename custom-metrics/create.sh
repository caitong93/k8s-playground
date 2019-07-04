#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

cluster_name=custom-metrics
kind create cluster --config cluster.yaml --name=${cluster_name}
kubeconfig_path=$(kind get kubeconfig-path --name=${cluster_name})
KUBECTL="kubectl --kubeconfig=${kubeconfig_path}"
${KUBECTL} create namespace monitoring 
${KUBECTL} create -f prometheus.yaml
${KUBECTL} create -f sample-app.yaml
${KUBECTL} create -f k8s-prometheus-adapter
