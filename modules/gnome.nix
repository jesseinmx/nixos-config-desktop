{ config, pkgs, lib, ... }:

let
  # Exportable GNOME package list so other modules can import it:
  gnome = {
    packages = import ./gnome-packages.nix { inherit pkgs; };
  };
in
{
  # This module provides GNOME configuration. Non-option helper values are kept
  # as local `let` bindings and are NOT exported as top-level options to avoid
  # triggering "option does not exist" errors during module evaluation.

  # Centralized GNOME module

  # Enable dconf for GNOME tweaks via Home Manager (note: also set in configuration.nix)
  programs.dconf.enable = true;

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = false;
  };

  # Use the exported package list — avoid referencing config.environment.systemPackages
  # to prevent evaluation recursion.
  environment.systemPackages = gnome.packages;

  # Workaround for GNOME autologin (preserve existing behavior)
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}