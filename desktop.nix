{ config, pkgs, lib, ... }:

{
  # Common desktop environment bits shared across sessions
  # Keep icons/cursors available system-wide
  environment.pathsToLink = [ "/share/icons" "/share/cursors" ];

  services.xserver.enable = true; # Enable the X server

  # =========================
  # GNOME Desktop Environment
  # =========================
  # Enabled by default. Disable if switching to another DE below.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.i3.enable = true;
  # Disable Wayland session for GNOME if desired
  services.xserver.displayManager.gdm.wayland = false;

  # =========================
  # i3 Window Manager
  # =========================
  # Enable LightDM as an alternative display manager for i3
  services.xserver.displayManager.lightdm.enable = false;
  # services.xserver.desktopManager.none.enable = true; # No specific desktop environment for i3

  # GNOME and i3 packages and tools
  environment.systemPackages = with pkgs; [
    # GNOME packages

    curtail
    exhibit #3d model viewer
    gnome-backgrounds
    gnome-control-center
    gnome-pomodoro
    gnome-screenshot
    gnome-settings-daemon
    gnome-shell
    gnome-themes-extra
    gnome-tweaks
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.appindicator
    gnomeExtensions.astra-monitor
    gnomeExtensions.auto-move-windows
    gnomeExtensions.burn-my-windows
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.easyeffects-preset-selector
    gnomeExtensions.forge
    gnomeExtensions.pano
    gnomeExtensions.search-light
    gnomeExtensions.search-light
    gnomeExtensions.tiling-shell
    gradia #app compress and convert
    gradience
    ignition #manage startup apps
    switcheroo #app compress and convert
    vaults #encrypted file vault
    xcursor-pro

    # i3 packages
    i3status # i3 status bar
    i3lock # i3 lock screen
    dmenu # application launcher

    # Common X11 utilities
    xorg.xev
    xorg.xrandr
    xorg.xset
    xorg.xinput
    xclip
    xsel
  ];

  

  # =========================
  # XFCE Desktop Environment
  # =========================
  # Disabled by default. To use XFCE, set the GNOME entries above to false and enable this:
  # services.xserver.displayManager.gdm.enable = false;
  # You may prefer LightDM for XFCE:
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = false;

  # Optional: add common XFCE packages here
  # environment.systemPackages = (with pkgs; [ xfce.xfce4-whiskermenu-plugin ]) ++ environment.systemPackages;

  # ===============================
  # Enlightenment Desktop Environment
  # ===============================
  # Disabled by default. To use Enlightenment, disable other DEs above and enable this:
  # You may also use LightDM or SDDM as a display manager.
  # services.xserver.displayManager.lightdm.enable = true;
  # or:
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.enlightenment.enable = false;

  # Optional: add Enlightenment-related packages here
  # environment.systemPackages = (with pkgs; [ enlightenment.terminology ]) ++ environment.systemPackages;
}
