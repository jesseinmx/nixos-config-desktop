# ⌨️ Keyboard Shortcuts — XFCE & GNOME

This file documents custom keyboard shortcuts, grouped by function. See grouping example in [home/jesseinmx/xfce.nix](home/jesseinmx/xfce.nix:13).

---

## 🚀 Grouped custom keybindings

### Application Menu
- XFCE: `super+space`
  - command: xfce4-popup-whiskermenu

### File Manager (Thunar/Nautilus)
- Open Thunar (XFCE)
  - binding(xfce): `super+e`
  - binding(xfce): `ctrl+alt+f`
    - command: thunar
- Open Nautilus (GNOME)
  - binding(gnome): `super+e`
  - binding(gnome): `ctrl+alt+f`
    - command: nautilus

### Screenshots (flameshot)

- Area selection
  - binding(gnome): `alt+shift+1`
  - binding(xfce): `alt+shift+exclam`
    - command: flameshot gui -p ${config.home.homeDirectory}/screenshots -c
- Current screen
  - binding(gnome): `alt+shift+2`
  - binding(xfce): `alt+shift+at`
    - command: flameshot screen -p ${config.home.homeDirectory}/screenshots -c
- Full (all monitors)
  - binding(gnome): `alt+shift+3`
  - binding(xfce): `alt+shift+numbersign`
    - command: flameshot full -p ${config.home.homeDirectory}/screenshots -c

### Media keys
- Volume up
  - binding(xfce): `XF86AudioRaiseVolume`
    - command: pactl set-sink-volume @DEFAULT_SINK@ +5%
- Volume down
  - binding(xfce): `XF86AudioLowerVolume`
    - command: pactl set-sink-volume @DEFAULT_SINK@ -5%
- Toggle mute
  - binding(xfce): `XF86AudioMute`
    - command: pactl set-sink-mute @DEFAULT_SINK@ toggle

### Workspaces navigation
- Next workspace
  - binding(xfce): `ctrl+alt+right`
    - command: "next_workspace_key"
- Previous workspace
  - binding(xfce): `ctrl+alt+left`
    - command: "prev_workspace_key"

### Window Management
- Cycle windows
  - binding(xfce): `alt+tab`
    - command: "cycle_windows_key"

### Conflicts / overrides
- XFCE: Neutralize `super+d` (Show Desktop) to avoid conflicts
  - setting: "xfwm4/custom/super+d" = null (see [home/jesseinmx/xfce.nix](home/jesseinmx/xfce.nix:11))

---

## 🛠️ How to apply changes
- XFCE: update [home/jesseinmx/xfce.nix](home/jesseinmx/xfce.nix:5) and run: `home-manager switch --flake .#jesseinmx`
- GNOME: update dconf settings in [home/jesseinmx/gnome.nix](home/jesseinmx/gnome.nix:56) under "org/gnome/settings-daemon/plugins/media-keys", then run: `home-manager switch --flake .#jesseinmx`

---

## 🤖 AI Prompt Instructions (Nix Configuration Format)

### Keybinding Formatting Rule

When generating the Nix configuration for a keybinding, **strictly adhere to the format and key symbols** used in the examples below for the respective environment (GNOME or XFCE).

### XFCE Guidance (Key Sym Conversion)

* **Rule:** XFCE keybindings must use the **shifted output character** (e.g., `!` for `Shift+1`).
* **Format:** The binding and command are combined into a single attribute key/value pair.
* **Example 1 (Screenshot area):**
    * *Source binding:* `alt+shift+!`
    * *Nix format:* `"commands/custom/<Alt><Shift>!" = "flameshot gui -p ${config.home.homeDirectory}/screenshots -c";`
* **Example 2 (File Manager):**
    * *Source binding:* `ctrl+alt+f`
    * *Nix format:* `"commands/custom/<Ctrl><Alt>f" = "thunar";`

### GNOME Guidance (Key Sym Conversion)

* **Rule:** GNOME keybindings must use the **base key** when the Shift modifier is present (e.g., `1` for `Shift+1`).
* **Format:** The binding and command are separate attributes within a binding set (`custom0`, `custom1`, etc.).
* **Example (Screenshot area):**
    * *Source binding:* `alt+shift+1`
    * *Nix format:*
        ```nix
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Screenshot area (flameshot)";
          command = "flameshot gui -p ${config.home.homeDirectory}/screenshots -c";
          binding = "<Alt><Shift>1";
        };
        ```