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

# Prefer Freearchy-specific stages; fall back to upstream if present
source "$OMARCHY_INSTALL/helpers/all.sh" 2>/dev/null || true
source "$OMARCHY_INSTALL/freearchy-preflight.sh" || source "$OMARCHY_INSTALL/preflight/all.sh" 2>/dev/null || true
source "$OMARCHY_INSTALL/freearchy-packaging.sh" || source "$OMARCHY_INSTALL/packaging/all.sh" 2>/dev/null || true
source "$OMARCHY_INSTALL/config/all.sh" 2>/dev/null || true
source "$OMARCHY_INSTALL/login/all.sh" 2>/dev/null || true
source "$OMARCHY_INSTALL/post-install/all.sh" 2>/dev/null || true

echo "Freearchy installation complete. Reboot recommended."
