resource "cloudflare_record" "A_ironpeak--be_168f1fc179f7ed3a6d313a177364c43b" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "home.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "A_ironpeak--services_e469584fda2002ffaf88ffa02c3fbac0" {
  zone_id  = cloudflare_zone.ironpeak--services.id
  name     = "ironpeak.services"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "A"
  value    = "104.198.14.52"
}

resource "cloudflare_record" "CNAME_ironpeak--be_4a025073d0c88466a5c8e370ce158b0a" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "CNAME_ironpeak--be_991601d72e65af2522b6de4965605a1a" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "www.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "CNAME_ironpeak--be_a226e8c58cf13ee0e113f5f7406ef29c" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "plex.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "CNAME_ironpeak--services_0265e587a4902e479bda11421475326d" {
  zone_id  =  cloudflare_zone.ironpeak--services.id
  name     = "www.ironpeak.services"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "A"
  value    = "104.198.14.52"
}

resource "cloudflare_record" "MX_ironpeak--be_2982ae5d13adf8fb3500e8d646b8dc3c" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "MX_ironpeak--be_2b326827df7e3bd6f65092555ba86d0a" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "MX_ironpeak--be_96a5322f9c88b00b68a433d9933e1aed" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "MX_ironpeak--be_c1c8c0537354ca357d7400db26efc9f2" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "MX_ironpeak--be_d642f18c6cae0fe3ba4867911508e16c" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_1b817ea45a4c8b3a52d07608cd392776" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "google-site-verification.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_5d516041a83a55ac02106f22d64468fc" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_8df110d6b3727ced8ac97efa265e7030" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_acbd354b05fcbbfae59d470f58571a4c" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_be9da15da0226dceb193120455fdbd89" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "_github-challenge-ironpeakservices.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}

resource "cloudflare_record" "TXT_ironpeak--be_d43b3f94e132d65e863220e1953dc62e" {
  zone_id  = cloudflare_zone.ironpeak--be.id
  name     = "ironpeak._domainkey.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "A"
  value    = "94.224.89.89"
}
