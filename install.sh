#!/bin/bash
# One-step install on GameShell. After connecting over SSH, run:
#   bash <(curl -sL https://raw.githubusercontent.com/zzxzzk115/WqxEmulator-GameShell/master/install.sh)
# Where GitHub is unreliable (e.g. mainland China), fetch this script through jsDelivr instead:
#   bash <(curl -sL https://cdn.jsdelivr.net/gh/zzxzzk115/WqxEmulator-GameShell@master/install.sh)
# Downloads then go through whichever is fastest right now: GitHub itself or one of the public proxies below.
# To choose yourself, set GH_PROXY (an empty value means GitHub directly):
#   GH_PROXY=https://ghfast.top/ bash <(curl -sL ...)
set -e
[ -n "$HOME" ] || { echo "HOME is not set." >&2; exit 1; }

# ---- fastest route to GitHub ----------------------------------------------------------------------------------
GH_MIRRORS="https://ghfast.top/ https://gh-proxy.com/ https://ghproxy.net/ https://gh.ddlc.top/"

# pick_github URL: prints "" (GitHub directly) or the proxy prefix that fetched the first 256 KB of URL fastest
# (6 s per try). GH_PROXY, when set, is used as is.
pick_github() {
  local url="$1" best="" best_speed=0 p out code size speed
  if [ -n "${GH_PROXY+set}" ]; then echo "$GH_PROXY"; return 0; fi
  echo "Testing download routes..." >&2
  for p in "" $GH_MIRRORS; do
    out=$(curl -sL -r 0-262143 -m 6 -o /dev/null -w '%{http_code} %{size_download} %{speed_download}' "$p$url" 2>/dev/null || true)
    read -r code size speed <<< "$out"
    size=${size%%.*}; speed=${speed%%.*}
    case "$code" in 200|206) ;; *) speed=0 ;; esac
    [ "${size:-0}" -ge 65536 ] || speed=0
    printf '  %-26s %6s KB/s\n' "${p:-https://github.com/}" "$(( ${speed:-0} / 1024 ))" >&2
    if [ "${speed:-0}" -gt "$best_speed" ]; then best_speed=${speed:-0}; best=$p; fi
  done
  if [ "$best_speed" -eq 0 ]; then echo "Could not reach GitHub or any proxy. Check the network, or set GH_PROXY." >&2; return 1; fi
  echo "Using ${best:-GitHub directly}" >&2
  echo "$best"
}

# fetch URL FILE: download through the chosen route, retrying a couple of times
fetch() { curl -fL --progress-bar --retry 2 --connect-timeout 10 -o "$2" "${GH}$1"; }

# ---- install --------------------------------------------------------------------------------------------------
REPO_ZIP="https://github.com/zzxzzk115/WqxEmulator-GameShell/archive/refs/heads/master.zip"
ZPIX="https://github.com/SolidZORO/zpix-pixel-font/releases/latest/download/zpix.ttf"
APP="$HOME/apps/Menu/WqxEmulator"

GH=$(pick_github "$ZPIX")
TMP=$(mktemp -d)
cd "$TMP"

echo "Downloading WqxEmulator..."
fetch "$REPO_ZIP" wqx.zip
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
if ! fetch "$ZPIX" "$APP/fonts/zpix.ttf"; then
  rm -f "$APP/fonts/zpix.ttf"
  echo "Could not download Zpix; the keyboard labels will use Arial."
fi

cd "$HOME"
rm -rf "$TMP"
echo "Done! Please refresh the menu."
