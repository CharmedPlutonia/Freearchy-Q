#!/bin/bash
# Freearchy config: theme, autostart, snapshots

set -e

echo "=== Freearchy Config ==="

OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"
USER_HOME="$HOME"

# Ensure config dirs
mkdir -p "$USER_HOME/.config/hypr"
mkdir -p "$USER_HOME/.config/quickshell"
mkdir -p "$USER_HOME/.config/omarchy/current/theme"

# Apply Freearchy blue theme
if [ -f "$OMARCHY_PATH/themes/freearchy-blue/colors.toml" ]; then
  cp -f "$OMARCHY_PATH/themes/freearchy-blue/colors.toml" "$USER_HOME/.config/omarchy/current/theme/colors.toml"
  echo "Applied Freearchy blue theme."
fi

# Basic Hyprland config if none exists
if [ ! -f "$USER_HOME/.config/hypr/hyprland.conf" ]; then
  cat > "$USER_HOME/.config/hypr/hyprland.conf" << 'EOF'
# Freearchy Hyprland base
monitor=,preferred,auto,1

exec-once = qs -c desktop
exec-once = hypridle

input {
  kb_layout = us
  follow_mouse = 1
}

general {
  gaps_in = 4
  gaps_out = 8
  border_size = 2
  col.active_border = rgba(20dff1ee)
  col.inactive_border = rgba(595959aa)
}

decoration {
  rounding = 8
}

bind = SUPER, Return, exec, alacritty
bind = SUPER, Q, killactive
bind = SUPER, M, exit
bind = SUPER, E, exec, nautilus
bind = SUPER, Space, exec, qs -c desktop ipc call palette toggle || true
EOF
  echo "Created basic Hyprland config with Quickshell autostart."
fi

# Session desktop file for Hyprland
mkdir -p "$USER_HOME/.local/share/wayland-sessions"
cat > "$USER_HOME/.local/share/wayland-sessions/freearchy.desktop" << 'EOF'
[Desktop Entry]
Name=Freearchy
Comment=Freearchy Hyprland + Quickshell
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
EOF

# Enable NetworkManager and Bluetooth if present
sudo systemctl enable --now NetworkManager 2>/dev/null || true
sudo systemctl enable --now bluetooth 2>/dev/null || true

# Snapshots
if [ "${FREEARCHY_SNAPSHOTS:-yes}" = "yes" ]; then
  echo "Configuring snapper snapshots..."
  if command -v snapper >/dev/null; then
    sudo snapper -c root create-config / 2>/dev/null || true
    sudo systemctl enable --now snapper-cleanup.timer 2>/dev/null || true
    echo "Snapper configured for root."
  else
    echo "snapper not found; skipping detailed config."
  fi
else
  echo "Snapshots skipped by user choice."
fi

# Set default shell if chosen
if [ -n "$FREEARCHY_SHELL" ] && [ "$FREEARCHY_SHELL" != "bash" ]; then
  if command -v "$FREEARCHY_SHELL" >/dev/null; then
    sudo chsh -s "$(command -v "$FREEARCHY_SHELL")" "$USER" || true
  fi
fi

echo "Config stage complete."
