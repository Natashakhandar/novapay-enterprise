# 02 - Deployment Strategies

## Blue-Green & Canary Implementation

NovaPay implements advanced deployment strategies to achieve true Zero-Downtime.

### 1. Canary Deployment (Primary Strategy)
Implemented via **Argo Rollouts** (`rollout.yaml`).
The traffic split strategy guarantees a minimized blast radius if a failure occurs.

**Traffic Progression:**
- **5% (Canary):** Exposes 5% of external traffic to the new pod. Pauses for 5 minutes.
- **25% (Expansion):** Increases traffic to 25%. Prometheus Analysis Template runs a health check for 10 minutes.
- **50% (Validation):** Increases to 50%. Runs another validation check.
- **100% (Full Rollout):** Old ReplicaSet is scaled down.

### 2. Blue-Green Strategy (Failover)
While Canary is the primary method, the architecture supports a full Blue-Green toggle via Istio VirtualServices.
- **Blue Environment:** `novapay-prod-blue`
- **Green Environment:** `novapay-prod-green`
- **Traffic Switch:** Atomic route update in Istio `VirtualService.yaml` from 100% Blue to 100% Green.
