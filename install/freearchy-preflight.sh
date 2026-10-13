#!/bin/bash
# Freearchy preflight: option selection before install
# Force interactive input from the controlling terminal so curl | bash works.

set -e

# Ensure gum is available for nicer menus
if ! command -v gum >/dev/null 2>&1; then
  echo "Installing gum for better menus..." >&2
  sudo pacman -Sy --noconfirm --needed gum || true
fi

TTY=/dev/tty
exec 3<&0  # save original stdin
exec <"$TTY" || { echo "Error: no controlling terminal for interactive install." >&2; exit 1; }

echo "=== Freearchy Preflight: Choose your options ===" >&2

# Prefer gum if available, otherwise plain prompts
if command -v gum >/dev/null 2>&1; then
  USE_GUM=1
else
  USE_GUM=0
fi

# Shell
if [ $USE_GUM -eq 1 ]; then
  SHELL_CHOICE=$(gum choose --header "Shell" bash fish zsh)
else
  echo "Shell? (bash/fish/zsh) [bash]:" >&2
  read -r SHELL_CHOICE
  SHELL_CHOICE=${SHELL_CHOICE:-bash}
fi
export FREEARCHY_SHELL="$SHELL_CHOICE"

# Terminals (multi)
if [ $USE_GUM -eq 1 ]; then
  TERMINALS=$(gum choose --no-limit --header "Terminals (multi)" alacritty foot ghostty kitty)
else
  echo "Terminals (space-separated, e.g. alacritty foot) [alacritty]:" >&2
  read -r TERMINALS
  TERMINALS=${TERMINALS:-alacritty}
fi
export FREEARCHY_TERMINALS="$TERMINALS"

# Browser
if [ $USE_GUM -eq 1 ]; then
  BROWSER=$(gum choose --header "Browser" chromium firefox ungoogled-chromium brave)
else
  echo "Browser? (chromium/firefox/...) [chromium]:" >&2
  read -r BROWSER
  BROWSER=${BROWSER:-chromium}
fi
export FREEARCHY_BROWSER="$BROWSER"

# Flatpak
if [ $USE_GUM -eq 1 ]; then
  FLATPAK=$(gum choose --header "Enable Flatpak?" yes no)
else
  echo "Enable Flatpak? (yes/no) [yes]:" >&2
  read -r FLATPAK
  FLATPAK=${FLATPAK:-yes}
fi
export FREEARCHY_FLATPAK="$FLATPAK"

# AI optional
if [ $USE_GUM -eq 1 ]; then
  AI=$(gum choose --header "Install AI tools?" no claude-code opencode)
else
  echo "AI tools? (no/claude-code/...) [no]:" >&2
  read -r AI
  AI=${AI:-no}
fi
export FREEARCHY_AI="$AI"

# Gaming optional
if [ $USE_GUM -eq 1 ]; then
  GAMING=$(gum choose --header "Install gaming extras?" no yes)
else
  echo "Gaming extras? (yes/no) [no]:" >&2
  read -r GAMING
  GAMING=${GAMING:-no}
fi
export FREEARCHY_GAMING="$GAMING"

# Snapshots
if [ $USE_GUM -eq 1 ]; then
  SNAPSHOTS=$(gum choose --header "Set up system snapshots (snapper + Limine)?" yes no)
else
  echo "Set up system snapshots (snapper + Limine)? (yes/no) [yes]:" >&2
  read -r SNAPSHOTS
  SNAPSHOTS=${SNAPSHOTS:-yes}
fi
export FREEARCHY_SNAPSHOTS="$SNAPSHOTS"

# Restore original stdin
exec 0<&3 3<&-

echo "Selections saved. Continuing with packaging..." >&2
echo "Shell: $FREEARCHY_SHELL" >&2
echo "Terminals: $FREEARCHY_TERMINALS" >&2
echo "Browser: $FREEARCHY_BROWSER" >&2
echo "Flatpak: $FREEARCHY_FLATPAK" >&2
echo "AI: $FREEARCHY_AI" >&2
echo "Gaming: $FREEARCHY_GAMING" >&2
echo "Snapshots: $FREEARCHY_SNAPSHOTS" >&2
