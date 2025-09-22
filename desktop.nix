{ config, pkgs, lib, ... }:

{
  # Common desktop environment bits shared across sessions
  # Keep icons/cursors available system-wide
  environment.pathsToLink = [ "/share/icons" "/share/cursors" ];

  # =========================
  # GNOME Desktop Environment
  # =========================
  # Enabled by default. Disable if switching to another DE below.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;

  # Resolve Budgie vs GNOME gsettings overrides collision by preferring GNOME
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce
    "/nix/var/nix/profiles/system/sw/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

  # GNOME packages and tools
  environment.systemPackages = with pkgs; [
    gnome-tweaks

    # Cursor themes for GNOME/X11  # wayland
    # adwaita-icon-theme
    # afterglow-cursors-recolored
    # bibata-cursors
    # bibata-cursors-translucent # broken symlink
    xcursor-pro
    # whitesur-cursors
    # xorg.xcursorthemes

    # Gnome Settings
    gnome-themes-extra
    gnome-settings-daemon
    gnome-shell
    gnome-control-center

    # Additional cursor support
    # hicolor-icon-theme

    # Wayland-specific cursor packages  # wayland
    # libsForQt5.breeze-qt5  # wayland
    gnome-backgrounds

    # GNOME extensions
    gnomeExtensions.appindicator

    # X11-specific packages
    xorg.xev
    xorg.xrandr
    xorg.xset
    xorg.xinput
    xclip
    xsel
  ];

  # =========================
  # XFCE (enable)
  # =========================
  services.xserver.desktopManager.xfce.enable = true;
  # environment.systemPackages = (with pkgs; [ xfce.xfce4-whiskermenu-plugin ]) ++ environment.systemPackages;

  # =========================
  # Additional Desktop Environments
  # =========================

  # Optional safe DEs you can enable if desired:
  services.xserver.desktopManager.mate.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.desktopManager.enlightenment.enable = true;

  # Safe window managers (pick any)
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.windowManager.fluxbox.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.icewm.enable = true;
  services.xserver.windowManager.openbox.enable = true;

}
