#!/bin/bash
# Freearchy preflight: option selection before install

set -e

echo "=== Freearchy Preflight: Choose your options ==="

# Simple menu using gum if available, else basic read
if command -v gum >/dev/null; then
  USE_GUM=1
else
  USE_GUM=0
fi

# Shell
if [ $USE_GUM -eq 1 ]; then
  SHELL_CHOICE=$(gum choose --header "Shell" bash fish zsh)
else
  echo "Shell? (bash/fish/zsh) [bash]:"
  read -r SHELL_CHOICE
  SHELL_CHOICE=${SHELL_CHOICE:-bash}
fi
export FREEARCHY_SHELL="$SHELL_CHOICE"

# Terminals (multi)
if [ $USE_GUM -eq 1 ]; then
  TERMINALS=$(gum choose --no-limit --header "Terminals (multi)" alacritty foot ghostty kitty)
else
  echo "Terminals (space-separated, e.g. alacritty foot) [alacritty]:"
  read -r TERMINALS
  TERMINALS=${TERMINALS:-alacritty}
fi
export FREEARCHY_TERMINALS="$TERMINALS"

# Browser
if [ $USE_GUM -eq 1 ]; then
  BROWSER=$(gum choose --header "Browser" chromium firefox ungoogled-chromium brave)
else
  echo "Browser? (chromium/firefox/...) [chromium]:"
  read -r BROWSER
  BROWSER=${BROWSER:-chromium}
fi
export FREEARCHY_BROWSER="$BROWSER"

# Flatpak
if [ $USE_GUM -eq 1 ]; then
  FLATPAK=$(gum choose --header "Enable Flatpak?" yes no)
else
  echo "Enable Flatpak? (yes/no) [yes]:"
  read -r FLATPAK
  FLATPAK=${FLATPAK:-yes}
fi
export FREEARCHY_FLATPAK="$FLATPAK"

# AI optional
if [ $USE_GUM -eq 1 ]; then
  AI=$(gum choose --header "Install AI tools?" no claude-code opencode)
else
  echo "AI tools? (no/claude-code/...) [no]:"
  read -r AI
  AI=${AI:-no}
fi
export FREEARCHY_AI="$AI"

# Gaming optional
if [ $USE_GUM -eq 1 ]; then
  GAMING=$(gum choose --header "Install gaming extras?" no yes)
else
  echo "Gaming extras? (yes/no) [no]:"
  read -r GAMING
  GAMING=${GAMING:-no}
fi
export FREEARCHY_GAMING="$GAMING"

echo "Selections saved. Continuing with packaging..."
echo "Shell: $FREEARCHY_SHELL"
echo "Terminals: $FREEARCHY_TERMINALS"
echo "Browser: $FREEARCHY_BROWSER"
echo "Flatpak: $FREEARCHY_FLATPAK"
echo "AI: $FREEARCHY_AI"
echo "Gaming: $FREEARCHY_GAMING"
