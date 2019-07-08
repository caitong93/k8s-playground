#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

KUBECONFIG=${KUBECONFIG:-""}
cluster_name=custom-metrics

if [ -z $KUBECONFIG ]; then
    kind delete cluster --name=${cluster_name}
else
    kubectl delete -f sample-app.yaml
    kubectl delete -f prometheus.yaml
    kubectl delete -f k8s-prometheus-adapter
    kubectl delete ns monitoring
fi


