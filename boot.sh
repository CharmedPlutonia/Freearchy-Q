#!/bin/bash

set -e

# Set install mode to online since boot.sh is used for curl installations
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

# Use freearchy-nightly by default
OMARCHY_REF="${OMARCHY_REF:-freearchy-nightly}"

sudo pacman -Syu --noconfirm --needed git

OMARCHY_REPO="${OMARCHY_REPO:-CharmedPlutonia/omachry-freearchy-testing}"

echo -e "\nCloning Freearchy (Omarchy 4 / Quickshell) from: https://github.com/${OMARCHY_REPO}.git"
echo -e "\033[38;2;32;223;241mUsing branch: $OMARCHY_REF\033[0m"
rm -rf ~/.local/share/omarchy/
git clone --branch "$OMARCHY_REF" "https://github.com/${OMARCHY_REPO}.git" ~/.local/share/omarchy >/dev/null

echo -e "\nInstallation starting..."
source ~/.local/share/omarchy/install.sh
