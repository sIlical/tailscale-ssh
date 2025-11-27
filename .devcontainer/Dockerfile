FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl gnupg2 iptables openssh-server iproute2 && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list >/dev/null && \
    apt-get update && apt-get install -y tailscale && \
    apt-get clean

# SSH config directory
RUN mkdir /var/run/sshd

# Copy custom SSH config
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22
