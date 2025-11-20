# /etc/nixos/virtualbox.nix
{ config, pkgs, ... }:

{
  # This setting should be in one place, like pkgs.nix,
  # but keeping it here is fine for now.
  nixpkgs.config.allowUnfree = true;

  # With the KVM conflict resolved, these two lines are all you need.
  # The system will now correctly handle the kernel modules automatically.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Add your user to the vboxusers group for permissions.
  users.extraGroups.vboxusers.members = [ "jesseinmx" ];

  # Add required packages for X11 support.  # wayland
  environment.systemPackages = with pkgs; [
    # qt6.qtwayland  # wayland
    qt6.qtbase
  ];

  # Block KVM Kernel
  boot.kernelParams = [ "module_blacklist=kvm_amd" ];

}
