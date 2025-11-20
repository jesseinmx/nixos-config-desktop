{ config, pkgs, lib, ... }:

{
  # Common desktop environment bits shared across sessions
  # Keep icons/cursors available system-wide
  environment.pathsToLink = [ "/share/icons" "/share/cursors" ];

  services.xserver.enable = true; # Enable the X server

  # GNOME configuration has been moved to ./modules/gnome.nix
  # Keep i3 Window Manager enabled here
  services.xserver.windowManager.i3.enable = true;

  # =========================
  # i3 Window Manager
  # =========================
  # Enable LightDM as an alternative display manager for i3
  services.xserver.displayManager.lightdm.enable = false;
  # services.xserver.desktopManager.none.enable = true; # No specific desktop environment for i3

  # GNOME and i3 packages and tools
  environment.systemPackages = with pkgs; [
    # i3 packages
    i3status
    i3lock
    dmenu

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
