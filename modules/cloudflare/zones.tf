resource "cloudflare_zone" "ironpeak--be" {
  meta {
    phishing_detected  = false
    wildcard_proxiable = false
  }

  paused = false
  plan   = "free"
  type   = "full"
  zone   = "ironpeak.be"
}

resource "cloudflare_zone" "ironpeak--services" {
  meta {
    phishing_detected  = false
    wildcard_proxiable = false
  }

  paused = false
  plan   = "free"
  type   = "full"
  zone   = "ironpeak.services"
}
