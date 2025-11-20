{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
    usbmuxd
    gphoto2
  ];

  services.usbmuxd.enable = true;

  # Optional: allow unprivileged FUSE mounts
  programs.fuse.userAllowOther = true;
}