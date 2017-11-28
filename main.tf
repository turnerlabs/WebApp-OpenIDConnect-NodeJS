provider "harbor" {
  credentials = "${file("~/.harbor/credentials")}"
}

resource "harbor_shipment" "app" {
  shipment = "azure-ad-authn-example"
  group    = "mss"
}

resource "harbor_shipment_env" "dev" {
  shipment    = "${harbor_shipment.app.id}"
  environment = "dev"
  barge       = "digital-sandbox"
  replicas    = 1 
  monitored   = false
  
  container {
    name = "azure-ad-authn-example"
    
    port {
      protocol              = "http"
      public_port           = 80
      value                 = 3000
      healthcheck           = "/health"
      healthcheck_timeout   = 8
      healthcheck_interval  = 10
      public                = false
    }
  }
}

output "dns_name" {
  value = "${harbor_shipment_env.dev.dns_name}"
}

output "lb_dns_name" {
  value = "${harbor_shipment_env.dev.lb_dns_name}"
}
