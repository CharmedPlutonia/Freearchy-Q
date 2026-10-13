#!/bin/bash
# Freearchy packaging: install base + chosen options
# Prefer stock Arch packages. Use Omarchy packages only where necessary for Quickshell integration.

set -e

echo "=== Freearchy Packaging ==="

# Ensure base tools and gum for better menus
sudo pacman -Syu --noconfirm --needed git base-devel gum

# Core packages needed for Omarchy 4 / Quickshell (stock where possible)
CORE_PKGS=(
  hyprland
  quickshell
  wayland
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  wl-clipboard
  grim
  slurp
  socat
  jq
  networkmanager
  bluez
  bluez-utils
  brightnessctl
  pamixer
  wireplumber
  pipewire
  pipewire-pulse
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  ttf-jetbrains-mono-nerd
  starship
  git
  fastfetch
  btop
  plymouth
  nautilus
)

sudo pacman -S --noconfirm --needed "${CORE_PKGS[@]}" || echo "Some core packages may need AUR or Omarchy repo"

# Snapshots / bootloader if chosen
if [ "${FREEARCHY_SNAPSHOTS:-yes}" = "yes" ]; then
  sudo pacman -S --noconfirm --needed limine snapper || echo "limine/snapper install issue"
fi

# Browser
case "$FREEARCHY_BROWSER" in
  firefox) sudo pacman -S --noconfirm --needed firefox ;;
  chromium) sudo pacman -S --noconfirm --needed chromium ;;
  *) sudo pacman -S --noconfirm --needed chromium ;;
esac

# Shell
case "$FREEARCHY_SHELL" in
  fish) sudo pacman -S --noconfirm --needed fish ;;
  zsh) sudo pacman -S --noconfirm --needed zsh ;;
  *) true ;;
esac

# Terminals
for term in $FREEARCHY_TERMINALS; do
  case "$term" in
    alacritty) sudo pacman -S --noconfirm --needed alacritty ;;
    foot) sudo pacman -S --noconfirm --needed foot ;;
    ghostty) echo "Ghostty may require AUR; skipping or use yay if available" ;;
    kitty) sudo pacman -S --noconfirm --needed kitty ;;
  esac
done

# Flatpak
if [ "$FREEARCHY_FLATPAK" = "yes" ]; then
  sudo pacman -S --noconfirm --needed flatpak
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || true
fi

# AI
if [ "$FREEARCHY_AI" != "no" ]; then
  echo "AI tools ($FREEARCHY_AI) may require AUR or manual install; noted for post-install."
fi

# Gaming
if [ "$FREEARCHY_GAMING" = "yes" ]; then
  echo "Gaming extras noted; install via Omarchy menu or steam later."
fi

# Force stock kernel (already default on Arch)
echo "Using stock linux kernel."

echo "Packaging stage complete."
