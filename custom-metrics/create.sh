#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

KUBECONFIG=${KUBECONFIG:-""}
cluster_name=custom-metrics

if [ -z $KUBECONFIG ]; then
    kind create cluster --config cluster.yaml --name=${cluster_name}
    KUBECONFIG=$(kind get kubeconfig-path --name=${cluster_name})
fi

KUBECTL="kubectl --kubeconfig=${KUBECONFIG}"
${KUBECTL} create namespace monitoring 
${KUBECTL} create -f prometheus.yaml
${KUBECTL} create -f sample-app.yaml
${KUBECTL} create -f k8s-prometheus-adapter
