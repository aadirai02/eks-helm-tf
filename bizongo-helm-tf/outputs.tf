output "bizongo_endpoint" {
    value = "http://${data.kubernetes_service.flask-chart.status.0.load_balancer.0.ingress.0.hostname}"
}
