#!/bin/bash
set -e

SERVICE_NAME=$1
NAMESPACE=${2:-"payments-prod"}

echo "[NovaPay Auto-Recovery] Initiating Rollback for $SERVICE_NAME in $NAMESPACE"

# Instantly revert Argo Rollout
kubectl argo rollouts undo $SERVICE_NAME -n $NAMESPACE

echo "[NovaPay Auto-Recovery] Waiting for traffic to drain back to stable version..."
kubectl argo rollouts status $SERVICE_NAME -n $NAMESPACE --timeout 60s

echo "[NovaPay Auto-Recovery] Rollback complete. System is stable."
