

resource "cloudflare_record" "A_ironpeakbe" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "CNAME"
  value    = "ironpeakbe.netlify.com"
}

resource "cloudflare_record" "A_statusironpeakbe" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "status.ironpeak.be"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "CNAME"
  value    = "statusironpeakbe.netlify.com"
}

resource "cloudflare_record" "CNAME_wwwironpeakbe" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "www.ironpeak.be"
  priority = "0"
  proxied  = true
  ttl      = "1"
  type     = "CNAME"
  value    = cloudflare_record.A_ironpeakbe.name
}

// -------------- mail records --------------------------------------------------------------

resource "cloudflare_record" "MX_ironpeakbe_4" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "10"
  proxied  = false
  ttl      = "1"
  type     = "MX"
  value    = "alt4.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_ironpeakbe_3" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "10"
  proxied  = false
  ttl      = "1"
  type     = "MX"
  value    = "alt3.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_ironpeakbe_2" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "5"
  proxied  = false
  ttl      = "1"
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_ironpeakbe_1" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "5"
  proxied  = false
  ttl      = "1"
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_ironpeakbe_0" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "1"
  proxied  = false
  ttl      = "1"
  type     = "MX"
  value    = "aspmx.l.google.com"
}

// -------------- verification records ------------------------------------------------------

resource "cloudflare_record" "TXT_ironpeakbe_github" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "_github-challenge-ironpeakservices"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "TXT"
  value    = "597d584a40"
}

resource "cloudflare_record" "TXT_ironpeakbe_google" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "google-site-verification"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "TXT"
  value    = "20-5OSqeFXSvmz5zuA1qMN5P1qa7SiPHzVWMA1xZdpg"
}

resource "cloudflare_record" "TXT_ironpeakbe_spf" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "TXT"
  value    = "v=spf1 include:_spf.google.com ~all"
}

resource "cloudflare_record" "TXT_ironpeakbe_domainkey" {
  zone_id  = cloudflare_zone.ironpeakbe.id
  name     = "ironpeak._domainkey.ironpeak.be"
  priority = "0"
  proxied  = false
  ttl      = "1"
  type     = "TXT"
  value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwC6LgxUFK0BLyZAXIxdPlawRa4z0V4HQCli02HderzZHDz+V8oLr/2FGlURClhqHnnBasWw7nP3fsA5n1CW3l38Yaif+5Z1itgqd9Mdxlvl49/IWzA+0tuyyWYoPvppQz/aGQZdFqGEkKcv1F8hzfbsp6xyFCaU2F0Jl+VNQz2ozxnJSXlGOp8kzNy2zx/+9DTt9JypcwJZZJrE6OVcjkz+nHs4Zf3eZZLRTfoq1nKEWiXLQB2Ycg5Qu8FJ6YmxNqJBIOrsrdYQGisOYYHerDgP3YFnBnPJEHLLGrjBSTyqPMUKKVp7AZMlsak2d4VkcUM5qm/tX+TK9B4v9szFwdwIDAQAB"
}
