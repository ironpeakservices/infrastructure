resource "cloudflare_zone" "ironpeakbe" {
  paused = false
#  plan   = "free"
  type   = "full"
  zone   = "ironpeak.be"
}

resource "cloudflare_zone" "ironpeakservices" {
  paused = false
#  plan   = "free"
  type   = "full"
  zone   = "ironpeak.services"
}
