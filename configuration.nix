# configuration.nix
{ config, pkgs, lib, ... }:

{
  # Keep ALL imports centralized here
  imports = [
    ./hardware-configuration.nix
    ./pkgs.nix
    ./virtualbox.nix
    # ./vagrant.nix
    ./gnome.nix
    ./firewall.nix
    ./services.nix
  ];

  # Enable flakes + new CLI (safe to leave even if already set)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # (Optional but useful for GNOME dconf tweaks via Home Manager)
  programs.dconf.enable = true;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale & time
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  users.users.jesseinmx = {
    isNormalUser = true;
    description = "Jesse";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
  };

  # Home Manager config is handled in flake.nix

  # Apps
  programs.firefox.enable = true;

  # Input (natural scrolling)
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    mouse.naturalScrolling = true;
  };

  # State version
  system.stateVersion = "25.05";
}

