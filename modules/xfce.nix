{ config, pkgs, lib, ... }:

let
  # Exportable XFCE package list (imported from modules/xfce-packages.nix)
  xfce = {
    packages = import ./xfce-packages.nix { inherit pkgs; };
  };
in
{
  # Minimal XFCE module — force-enable the desktop
  services.xserver.desktopManager.xfce.enable = lib.mkForce true;

  # Use the exported package list — avoid referencing config.environment.systemPackages
  # to prevent evaluation recursion (same pattern as modules/gnome.nix / modules/i3.nix).
  environment.systemPackages = xfce.packages;
}