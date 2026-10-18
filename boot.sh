#!/bin/bash

set -e

# curl | bash has no keyboard. Re-open this script on the terminal before sudo or menus.
if [[ ! -t 0 && -e /dev/tty ]]; then
  tmp=$(mktemp /tmp/freearchy-q-boot.XXXXXX.sh)
  curl -fsSL "https://raw.githubusercontent.com/CharmedPlutonia/omachry-freearchy-testing/freearchy-nightly/boot.sh" -o "$tmp"
  chmod 700 "$tmp"
  exec bash "$tmp" </dev/tty
fi

export OMARCHY_ONLINE_INSTALL=true
export FREEARCHY=true

ansi_art=$(cat <<'EOF'
█████████  █████████  █████████  █████████    ███████    █████████   ███████   ██     ██  ██     ██
█████████  █████████  █████████  █████████   █████████   █████████  █████████  ██     ██  ██     ██
███        ███    ███ ███        ███        ███     ███  ███    ███ ███        ███   ███  ███   ███
███        ███    ███ ███        ███        ███     ███  ███    ███ ███        ███   ███  ███   ███
███████    █████████  ███████    ███████    ███████████  █████████  ███        █████████   ███████
███████    █████████  ███████    ███████    ███████████  █████████  ███        █████████    █████
███        ███  ███   ███        ███        ███     ███  ███  ███   ███        ███   ███     ███
███        ███   ███  ███        ███        ███     ███  ███   ███  ███        ███   ███     ███
███        ███    ███ █████████  █████████  ███     ███  ███    ███  █████████ ███   ███     ███
███        ███    ███ █████████  █████████  ███     ███  ███    ███   ███████  ███   ███     ███
EOF
)

clear
echo -e "\n\033[38;2;32;223;241m${ansi_art}\033[0m\n"

OMARCHY_REF="${OMARCHY_REF:-freearchy-nightly}"
OMARCHY_REPO="${OMARCHY_REPO:-CharmedPlutonia/omachry-freearchy-testing}"

sudo pacman -Sy --noconfirm --needed git

echo -e "\nCloning Freearchy Q from: https://github.com/${OMARCHY_REPO}.git"
echo -e "\033[38;2;32;223;241mUsing branch: $OMARCHY_REF\033[0m"
rm -rf ~/.local/share/omarchy/
git clone --branch "$OMARCHY_REF" "https://github.com/${OMARCHY_REPO}.git" ~/.local/share/omarchy >/dev/null

echo -e "\nInstallation starting..."
source ~/.local/share/omarchy/install.sh
