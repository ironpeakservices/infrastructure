#!/usr/bin/env bash 
generate_CA () {
  type openssl >/dev/null 2>&1 || { echo >&2 "OpenSSL is required on your local machine to generate the CA."; exit 1; } && \
  openssl genrsa -out certs/ca-key.pem 2048 && \
  openssl req -x509 -new -nodes -key certs/ca-key.pem -days 10000 -out certs/ca.pem -subj "/CN=swarm-ca"
}

generate_swarm_certs () {
	type openssl >/dev/null 2>&1 || { echo >&2 "OpenSSL is required on your local machine to generate the CA."; exit 1; } && \
	openssl genrsa -out certs/swarm-primary-priv-key.pem 2048 && \
	openssl req -new -key certs/swarm-primary-priv-key.pem -out certs/swarm-primary.csr -subj "/CN=swarm" && \
  openssl x509 -req -days 1825 -in certs/swarm-primary.csr -CA certs/ca.pem -CAkey certs/ca-key.pem -CAcreateserial -out certs/swarm-primary-cert.pem -extensions v3_req 
}

#SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
#echo $SCRIPTPATH
if [ -f certs/ca.pem ]; then
	echo "Swarm cert already exists..."
else
	echo "Creating CA certs, Swarm certs"
	generate_CA && \
	generate_swarm_certs
fi
