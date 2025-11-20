{ config, pkgs, lib, ... }:

let
  i3 = {
    packages = with pkgs; [
      i3status
      i3lock
      dmenu
      xorg.xev
      xorg.xrandr
      xorg.xset
      xorg.xinput
      xclip
      xsel
    ];
  };
in
{
  # Enable i3 window manager and related settings.
  services.xserver.windowManager.i3.enable = true;

  # Optionally enable LightDM as an alternative display manager (kept false by default).
  services.xserver.displayManager.lightdm.enable = false;

  # Export the package list so it can be used by other modules if needed.
  environment.systemPackages = i3.packages;
}