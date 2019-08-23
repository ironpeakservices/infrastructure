[Service]
ExecStart=
ExecStart=/usr/bin/dockerd \
  -H unix:///var/run/docker.sock \
  --tlsverify \
  --tlscacert=/certs/ca.pem \
  --tlscert=/certs/swarm-cert.pem \
  --tlskey=/certs/swarm-priv-key.pem \
  --storage-driver=overlay2 \
  --dns 1.1.1.1 --dns 1.0.0.1 \
  --log-driver json-file \
  --log-opt max-size=50m --log-opt max-file=10
