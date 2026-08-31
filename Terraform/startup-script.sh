#!/bin/bash
set -e

# Install Docker
apt-get update -y
apt-get install -y ca-certificates curl gnupg git
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable docker
systemctl start docker
usermod -aG docker debian # <- important

# Clone the repo and bring the stack up
cd /opt
git clone https://github.com/Adeola0507/multi-vm-app-ci-cd.git ci-teaching-kit
cd ci-teaching-kit
docker compose up -d --build

echo "CI Stack deployed. Nexus:8081 Jenkins:8080 API:3000"