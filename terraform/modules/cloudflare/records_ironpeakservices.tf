resource "cloudflare_record" "A_ironpeakservices" {
  zone_id  = cloudflare_zone.ironpeakservices.id
  name     = "ironpeak.services"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "A"
  value    = "104.198.14.52"
}

resource "cloudflare_record" "CNAME_wwwironpeakservices" {
  zone_id  =  cloudflare_zone.ironpeakservices.id
  name     = "www.ironpeak.services"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "CNAME"
  value    = cloudflare_record.A_ironpeakservices.name
}