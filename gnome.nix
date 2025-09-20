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
}
