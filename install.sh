#!/usr/bin/env bash
set -Eeuo pipefail

REPO="Zuvpn/Qazi"
BRANCH="main"
BIN="/usr/local/bin/Qazi"

if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "❌ لطفاً با root اجرا کن:"
  echo "curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/install.sh | sudo bash"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "📦 نصب curl ..."
  apt update -y && apt install -y curl
fi

echo "⬇️ دریافت Qazi ..."
curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/qazi" -o "$BIN"
chmod +x "$BIN"

echo "✅ نصب شد: $BIN"

echo
if [[ -t 0 ]]; then
  exec "$BIN"
elif [[ -r /dev/tty ]]; then
  exec "$BIN" </dev/tty
else
  echo "برای اجرا بزن: sudo Qazi"
fi
