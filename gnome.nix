{ config, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Ensure cursor themes are available system-wide
  environment.pathsToLink = [ "/share/icons" "/share/cursors" ];

  # GNOME packages and tools
  environment.systemPackages = with pkgs; [
    gnome-tweaks
 
    # Cursor themes for GNOME/Wayland
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
 
    # Wayland-specific cursor packages
    libsForQt5.breeze-qt5
    gnome-backgrounds
 
    # GNOME extensions
    gnomeExtensions.appindicator

  ];
}
