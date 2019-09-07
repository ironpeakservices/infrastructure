resource "cloudflare_zone" "ironpeak--be" {
  paused = false
  plan   = "free"
  type   = "full"
  zone   = "ironpeak.be"
}

resource "cloudflare_zone" "ironpeak--services" {
  paused = false
  plan   = "free"
  type   = "full"
  zone   = "ironpeak.services"
}
