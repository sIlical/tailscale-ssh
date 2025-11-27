#!/usr/bin/env bash
set -e

echo "🔄 Enabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

echo "🚀 Starting tailscaled..."
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

sleep 3

if [ -n "$TAILSCALE_AUTHKEY" ]; then
  echo "🔐 Authenticating Tailscale..."
  tailscale up --ssh --authkey=$TAILSCALE_AUTHKEY --accept-routes --accept-dns
else
  echo "⚠️ No TAILSCALE_AUTHKEY found. Please run manually:"
  echo "tailscale up --ssh --authkey=<YOUR_KEY>"
fi

echo "🔐 Starting SSH service..."
service ssh restart

echo "🎉 Tailscale + SSH Setup Complete!"
tailscale ip -4
