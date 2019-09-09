{
	"hosts": ["unix://var/run/docker.sock", "tcp://0.0.0.0:2376"],

    "dns": ["1.1.1.1", "1.0.0.1"],

    "disable-legacy-registry": true,

    "icc": false,

    "live-restore": false,

    "log-driver": "json-file",
     "log-opts": {
		"max-size": "10m",
		"max-file":"10"
    },

	"storage-driver": "overlay2",

    "userland-proxy": false,

    "userns-remap": "container:container",

    "no-new-privileges": true,

	"default-runtime": "runc",

    "content-trust": {
        "mode": "permissive"
    },

    "tls": true,
	"tlsverify": true,
	"tlscacert": "/etc/docker/certs/ca.pem",
	"tlscert": "/etc/docker/certs/swarm-cert.pem",
	"tlskey": "/etc/docker/certs/swarm-priv-key.pem"
}