package kubernetes.admission

# Block containers that run as root (PCI DSS Compliance)
deny[msg] {
  input.request.kind.kind == "Pod"
  container := input.request.object.spec.containers[_]
  not container.securityContext.runAsNonRoot
  msg := sprintf("Container %v is not allowed to run as root.", [container.name])
}

# Require images from private ECR only (Supply Chain Security)
deny[msg] {
  input.request.kind.kind == "Pod"
  container := input.request.object.spec.containers[_]
  not startswith(container.image, "ecr.aws/novapay/")
  msg := sprintf("Container %v is using an unapproved external registry.", [container.name])
}
