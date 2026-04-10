#!/bin/bash

set -e

echo "[1] Install XFCE + XRDP..."
sudo apt update && sudo apt install -y xfce4 xfce4-goodies xrdp && echo xfce4-session > ~/.xsession && sudo systemctl enable xrdp --now
sudo apt-get install -y \
  xfdesktop4 \
  xfce4-panel \
  xfce4-session \
  gvfs \
  gvfs-backends \
  gnome-icon-theme \
  tango-icon-theme \
  adwaita-icon-theme \
  xfce4-icon-theme

echo "[2] Root XFCE session..."
echo xfce4-session > /root/.xsession

echo "[3] Restart XRDP..."
sudo systemctl restart xrdp

echo "[4] Install xorgxrdp..."
sudo apt install xorgxrdp -y

echo "[5] Fix permissions..."
sudo adduser root ssl-cert

echo "[6] Configure Xwrapper..."
echo "allowed_users=anybody" | sudo tee /etc/X11/Xwrapper.config
echo "needs_root_rights=yes" | sudo tee -a /etc/X11/Xwrapper.config

echo "[7] Final XFCE root fix..."
echo startxfce4 > /root/.xsession
chmod +x /root/.xsession

echo "[8] Restart services..."
sudo systemctl restart xrdp
sudo systemctl restart xrdp-sesman

echo ""
echo "✅ Done. Reboot recommended:"
echo "sudo reboot"
