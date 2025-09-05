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
    adwaita-icon-theme
    gnome-themes-extra
    gnome-settings-daemon
    gnome-shell
    gnome-control-center
 
    # Additional cursor support
    xorg.xcursorthemes
    hicolor-icon-theme
 
    # Wayland-specific cursor packages
    libsForQt5.breeze-qt5
    gnome-backgrounds
 
    # GNOME extensions
    gnomeExtensions.appindicator

];

    # Add GPaste to GNOME startup applications
    environment.etc."xdg/autostart/gpaste-daemon.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=GPaste
      Comment=GNOME clipboard manager
      Exec=gpaste-daemon
      Terminal=false
      X-GNOME-Autostart-enabled=true
    '';

}
