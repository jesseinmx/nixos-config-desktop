# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # General system packages
  environment.systemPackages = with pkgs; [
    
    aider-chat-with-browser
    alacritty
    appimage-run
    bat
    bitwarden
    chezmoi
    chromium
    codex
    cifs-utils
    age
    curl
    docker
    eza
    firefox
    gemini-cli
    git
    git-open
    gnumeric
    go
    google-chrome
    gpaste
    htop
    insync
    lazygit
    netbird
    neovim
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    nmap
    obs-studio
    pavucontrol
    pipewire
    psmisc
    qutebrowser
    ripgrep
    shotcut
    sops
    tmux
    tree
    v4l-utils
    vim
    wakatime
    wget
    wireplumber
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-utils
    zoxide

  ];

  # Firefox config
  programs.firefox = {
    enable = true;
    policies = {
      "DisableFirefoxAccounts" = false;
    };
  };

  # Add polkit support
  programs.dconf.enable = true; # often needed with GNOME/KDE

  services.netbird.enable = true;

  # services.flatpak.enable = true;

  services.printing = {
    enable = true;
    drivers = [pkgs.brlaser ];
  };

  # Duplicati backup service (minimal configuration)
  services.duplicati = {
    enable = true;
    user = "jesseinmx";
    dataDir = "/var/lib/duplicati";
    
    # These options are moved up one level
    port = 8200;
    interface = "127.0.0.1";
  };


  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  
}
