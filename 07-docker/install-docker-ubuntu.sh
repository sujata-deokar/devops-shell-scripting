
#!/usr/bin/env bash

# Script Name: install-docker.sh
# Created by: Sujata Deokar
# Purpose: Install Docker Engine on Ubuntu
# Repository: devops-shell-scripting

set -Eeuo pipefail

echo "=========================================="
echo "       DOCKER INSTALLATION SCRIPT"
echo "       Created by: Sujata Deokar"
echo "       Operating System: Ubuntu"
echo "=========================================="

if [[ "$EUID" -eq 0 ]]; then
    echo "Run this script as a normal user with sudo access."
    exit 1
fi

if [[ ! -r /etc/os-release ]]; then
    echo "Cannot identify the operating system."
    exit 1
fi

. /etc/os-release

if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "This script supports Ubuntu only."
    exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required."
    exit 1
fi

echo ""
echo "Step 1: Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

echo ""
echo "Step 2: Setting up Docker's keyring..."
sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

echo ""
echo "Step 3: Adding the official Docker repository..."

sudo tee /etc/apt/sources.list.d/docker.sources \
    >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: ${UBUNTU_CODENAME:-$VERSION_CODENAME}
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

echo ""
echo "Step 4: Installing Docker Engine..."
sudo apt-get update

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo ""
echo "Step 5: Starting Docker..."
sudo systemctl enable --now docker

echo ""
echo "Step 6: Checking Docker installation..."
sudo systemctl --no-pager --full status docker
sudo docker --version
sudo docker compose version

echo ""
echo "=========================================="
echo " Docker installation completed!"
echo " Script created by: Sujata Deokar"
echo "=========================================="
