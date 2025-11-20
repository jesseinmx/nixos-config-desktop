{ config, pkgs, lib, ... }:

{
  # Minimal XFCE module — force-enable the desktop
  services.xserver.desktopManager.xfce.enable = lib.mkForce true;
}