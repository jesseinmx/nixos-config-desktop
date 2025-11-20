# XFCE Cheatsheet

Fast reference for my XFCE setup on NixOS: common shortcuts, window actions, and how to apply changes.

## Keyboard shortcuts (XFCE only)

| Key | Action | Command/Notes |
|-----|--------|----------------|
| Super+Space | Open application menu | xfce4-popup-whiskermenu |
| Super+E | Open file manager (Thunar) | thunar |
| Ctrl+Alt+F | Open file manager (Thunar) | thunar |
| Alt+Shift+! (Shift+1) | Screenshot area to ~/screenshots | flameshot gui -p ~/screenshots -c |
| Alt+Shift+@ (Shift+2) | Screenshot current screen to ~/screenshots | flameshot screen -p ~/screenshots -c |
| Alt+Shift+# (Shift+3) | Screenshot all monitors to ~/screenshots | flameshot full -p ~/screenshots -c |
| XF86AudioRaiseVolume | Volume up +5% | pactl set-sink-volume @DEFAULT_SINK@ +5% |
| XF86AudioLowerVolume | Volume down -5% | pactl set-sink-volume @DEFAULT_SINK@ -5% |
| XF86AudioMute | Toggle mute | pactl set-sink-mute @DEFAULT_SINK@ toggle |
| Ctrl+Alt+Right | Next workspace | Window manager action |
| Ctrl+Alt+Left | Previous workspace | Window manager action |
| Alt+Tab | Cycle windows | Window switcher |
| Ctrl+Alt+Up | Show window list | xfdesktop --windowlist |

## Window moving and resizing (xfwm4 defaults)

- Move window: Hold Alt, Left-click and drag anywhere inside the window
- Resize window: Hold Alt, Right-click and drag anywhere inside the window
- Tip: The direction you drag and where you start determines which edges resize.

## Notes

- Super+D (Show Desktop) is neutralized to avoid conflicts (handled in xfwm4/custom settings).

## How to apply changes

- Edit bindings and settings in [home/jesseinmx/xfce.nix](home/jesseinmx/xfce.nix).
- Apply with: `home-manager switch --flake .#jesseinmx`

## Related files

- [home/jesseinmx/xfce.nix](home/jesseinmx/xfce.nix)
- [modules/xfce.nix](modules/xfce.nix)
- [modules/xfce-packages.nix](modules/xfce-packages.nix)
- [home/jesseinmx/keybindings.md](home/jesseinmx/keybindings.md)