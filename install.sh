#!/bin/bash

# Freearchy Q online installer.
# Stage order matches Omarchy 4.0.4 (hardware, config, login, user, post-install).
# Packages come from official Arch. There is no Omarchy mirror and no linux-omarchy.

set -eEo pipefail

export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_INSTALL_LOG_FILE="/var/log/omarchy-install.log"
export PATH="$OMARCHY_PATH/bin:$PATH"
export FREEARCHY=true
export OMARCHY_LOG_TO_STDOUT=1

source "$OMARCHY_INSTALL/helpers/logging.sh"
start_install_log

# Choices have to stay in this shell. Packaging reads them.
source "$OMARCHY_INSTALL/freearchy-preflight.sh"
source "$OMARCHY_INSTALL/freearchy-packaging.sh"

# A hardware step that does not apply to this machine must not abort the rest.
run_stage() {
  local stage="$1"
  [[ -f "$stage" ]] || return 0
  set +e
  # shellcheck disable=SC1090
  source "$stage"
  set -e
}

run_stage "$OMARCHY_INSTALL/hardware/all.sh"
run_stage "$OMARCHY_INSTALL/config/all.sh"
run_stage "$OMARCHY_INSTALL/login/all.sh"
run_stage "$OMARCHY_INSTALL/user/all.sh"
run_stage "$OMARCHY_INSTALL/post-install/all.sh"

# Branding and the session file come last so they win over upstream defaults.
source "$OMARCHY_INSTALL/freearchy-config.sh"

stop_install_log
echo
echo "Freearchy Q is installed."
echo "Reboot, then select the Freearchy session."
