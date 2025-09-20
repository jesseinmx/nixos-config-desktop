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
  # Disable Wayland session for GNOME if desired
  services.xserver.displayManager.gdm.wayland = false;

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