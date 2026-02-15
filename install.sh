#!/usr/bin/env bash
set -Eeuo pipefail

REPO="Zuvpn/Qazi"
BRANCH="main"
BIN_PATH="/usr/local/bin/Qazi"

need_root() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    echo "❌ لطفاً با root اجرا کن."
    echo "مثال: sudo bash <(curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/install.sh)"
    exit 1
  fi
}

ensure_deps() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "📦 نصب curl ..."
    if command -v apt >/dev/null 2>&1; then
      apt update -y
      apt install -y curl
    elif command -v yum >/dev/null 2>&1; then
      yum install -y curl
    else
      echo "❌ package manager پیدا نشد. curl را دستی نصب کن."
      exit 1
    fi
  fi
}

install_qazi() {
  echo "⬇️ دریافت Qazi از GitHub ..."
  curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/qazi" -o "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "✅ نصب شد: $BIN_PATH"
}

run_menu() {
  echo
  echo "🚀 اجرای Qazi ..."
  exec "$BIN_PATH"
}

need_root
ensure_deps
install_qazi
run_menu
