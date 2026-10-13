#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Omarchy / Freearchy locations
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_INSTALL_LOG_FILE="/var/log/omarchy-install.log"
export PATH="$OMARCHY_PATH/bin:$PATH"
export FREEARCHY=true

echo "Freearchy Quattro installer starting..."

# Helpers (best effort)
source "$OMARCHY_INSTALL/helpers/logging.sh" 2>/dev/null || true

# Preflight (interactive options) — must succeed
if [ -f "$OMARCHY_INSTALL/freearchy-preflight.sh" ]; then
  source "$OMARCHY_INSTALL/freearchy-preflight.sh"
else
  echo "Warning: freearchy-preflight.sh missing" >&2
fi

# Packaging
if [ -f "$OMARCHY_INSTALL/freearchy-packaging.sh" ]; then
  source "$OMARCHY_INSTALL/freearchy-packaging.sh"
fi

# Freearchy-specific config (theme, autostart, snapshots)
if [ -f "$OMARCHY_INSTALL/freearchy-config.sh" ]; then
  source "$OMARCHY_INSTALL/freearchy-config.sh"
fi

# Upstream stages if they exist and helpers are present
if [ -f "$OMARCHY_INSTALL/config/all.sh" ] && type run_logged >/dev/null 2>&1; then
  source "$OMARCHY_INSTALL/config/all.sh" || true
fi

if [ -f "$OMARCHY_INSTALL/login/all.sh" ] && type run_logged >/dev/null 2>&1; then
  source "$OMARCHY_INSTALL/login/all.sh" || true
fi

echo ""
echo "Freearchy installation complete."
echo "Reboot, then select the Freearchy session (or start Hyprland) at login."
echo "Quickshell should autostart via the Hyprland config."
