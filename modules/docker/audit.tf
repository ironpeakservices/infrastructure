  # apply auditd configuration for docker services & files
  provisioner "remote-exec" {
    inline = [
      # install auditd
      "apt-get install -y auditd",
      # 1.5  - Ensure auditing is configured for the Docker daemon
      "echo '-w /usr/bin/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules'",
      # 1.6  - Ensure auditing is configured for Docker files and directories - /var/lib/docker
      "echo '-w /var/lib/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.7  - Ensure auditing is configured for Docker files and directories - /etc/docker"
      "echo 'echo '-w /etc/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.8  - Ensure auditing is configured for Docker files and directories - docker.service
      "echo 'echo '-w /lib/systemd/system/docker.service -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.9  - Ensure auditing is configured for Docker files and directories - docker.socket
      "echo 'echo '-w /lib/systemd/system/docker.socket -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.10 - Ensure auditing is configured for Docker files and directories - /etc/default/docker
      "echo 'echo '-w /etc/default/docker -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.11 - Ensure auditing is configured for Docker files and directories - /etc/docker/daemon.json
      "echo 'echo '-w /etc/docker/daemon.json -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.12 - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-containerd
      "echo 'echo '-w /usr/bin/docker-containerd -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # 1.13 - Ensure auditing is configured for Docker files and directories - /usr/bin/docker-runc
      "echo 'echo '-w /usr/bin/docker-runc -p wa' | sudo tee -a /etc/audit/rules.d/audit.rules",
      # now apply those changes
      "sudo service auditd restart",
    ]
}