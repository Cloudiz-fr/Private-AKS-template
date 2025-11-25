resource "helm_release" "myapp" {
  name             = "myapp"
  namespace        = "myapp"
  create_namespace = true

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  values = [
    yamlencode({
      service = {
        type = "ClusterIP"
        port = 80
      }
      ingress = {
        enabled   = true
        className = "azure/application-gateway"
        annotations = {
          "kubernetes.io/ingress.class"                     = "azure/application-gateway"
          "appgw.ingress.kubernetes.io/backend-path-prefix" = "/"
        }
        hosts = [
          {
            host = "demo.internal.local"
            paths = [
              {
                path     = "/"
                pathType = "Prefix"
              }
            ]
          }
        ]
      }
    })
  ]
}
