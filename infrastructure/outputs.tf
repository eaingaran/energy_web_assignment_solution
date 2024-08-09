output "argocd_url" {
  value = helm_release.argocd.status.load_balancer.ingress[0].hostname
}