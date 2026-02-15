#!/usr/bin/env bash
set -Eeuo pipefail

REPO="mmdaliah/Qazi-english-"
BRANCH="main"
BIN="/usr/local/bin/Qazi"

if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "❌ Please run as root:"
  echo "curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/install.sh | sudo bash"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "📦 Installing curl ..."
  apt update -y && apt install -y curl
fi

echo "⬇️ Downloading Qazi ..."
curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/qazi" -o "$BIN"
chmod +x "$BIN"

echo "✅ Installed: $BIN"
echo

if [[ -t 0 ]]; then
  exec "$BIN"
elif [[ -r /dev/tty ]]; then
  exec "$BIN" </dev/tty
else
  echo "ℹ️ Installed successfully. Run: $BIN"
fi
