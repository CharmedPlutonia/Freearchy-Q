# Freearchy (Omarchy 4 / Quickshell)

Freearchy is a stock-Arch oriented fork of Omarchy 4 (Quattro), using the Quickshell desktop shell.

## Features
- Official Arch repositories preferred. Omarchy packages used only when required for shell integration.
- Stock `linux` kernel.
- Limine bootloader with encrypted disk option.
- Snapshot support (snapper / omasnap).
- Pre-install choice menu: Shell, Terminal(s), Browser, Gaming, Themes, Webapps, Apps, Flatpak, AI.
- Dark blue-based default theme for install.
- Branding switched to Freearchy.
- Can track upstream Omarchy updates via branch merges without losing Freearchy changes.

## Install

On a fresh Arch Linux system:

```bash
curl -fsSL https://raw.githubusercontent.com/CharmedPlutonia/omachry-freearchy-testing/freearchy-nightly/boot.sh | bash
```

Or set `OMARCHY_REF` to choose a branch.

## License

Released under the MIT License. Upstream Omarchy by DHH.
