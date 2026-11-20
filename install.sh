#!/bin/bash
# One-step install on GameShell. After connecting over SSH, run:
#   bash <(curl -sL https://raw.githubusercontent.com/zzxzzk115/WqxEmulator-GameShell/master/install.sh)
# If GitHub is slow where you are, put a GitHub proxy prefix of your choice in GH_PROXY, e.g.
#   GH_PROXY=https://your-proxy.example/ bash <(curl -sL ...)
set -e
GH=${GH_PROXY:-}
APP="$HOME/apps/Menu/WqxEmulator"
TMP=$(mktemp -d)
cd "$TMP"

echo "Downloading WqxEmulator..."
wget -q -O wqx.zip "${GH}https://github.com/zzxzzk115/WqxEmulator-GameShell/archive/refs/heads/master.zip"
unzip -q wqx.zip

echo "Installing to $APP..."
mkdir -p "$HOME/apps/Menu"
rm -rf "$APP"
cp -r WqxEmulator-GameShell-master/WqxEmulator "$APP"
# the launcher points at /home/cpi; use this account's home instead
sed -i "s|/home/cpi|$HOME|g" "$APP/WqxEmulator.sh"
chmod +x "$APP/WqxEmulator.sh"

# Zpix (the key labels' pixel font) comes from its own release: its licence does not allow bundling it here
echo "Downloading the Zpix font..."
if ! wget -q -O "$APP/fonts/zpix.ttf" "${GH}https://github.com/SolidZORO/zpix-pixel-font/releases/latest/download/zpix.ttf"; then
  rm -f "$APP/fonts/zpix.ttf"
  echo "Could not download Zpix; the keyboard labels will use Arial."
fi

cd "$HOME"
rm -rf "$TMP"
echo "Done! Please refresh the menu."
