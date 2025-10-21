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
    abiword
    age
    aider-chat-with-browser
    alacritty
    appimage-run
    arp-scan
    awscli
    bat
    bitwarden
    bitwarden-cli
    chezmoi
    calibre
    cargo
    chromium
    cifs-utils
    codex
    copyq
    curl
    dig
    docker
    easyeffects
    eza
    ffmpeg-full
    file
    firefox
    flameshot
    freerdp
    gemini-cli
    ghostty
    git
    git-open
    gnome-pomodoro
    gnome-screenshot
    gnumeric
    go
    google-chrome
    granted
    home-manager
    htop
    i3
    i3lock
    i3status
    inkscape
    jq
    kdePackages.kdenlive
    kitty
    kubectl
    lazydocker
    lazygit
    neovim
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    netbird
    nmap
    nodejs
    nodePackages.aws-cdk
    nodePackages.npm
    obs-studio
    packer
    pavucontrol
    pyenv
    python3
    pipewire
    podman
    psmisc
    qutebrowser
    rclone
    remmina
    ripgrep
    rpi-imager
    shotcut
    signal-desktop
    sops
    tmux
    tree
    tty-clock
    uv
    v4l-utils
    vagrant
    vault
    vim
    vlc
    vscode
    wakatime
    wget
    wireplumber
    wmctrl
    # wl-clipboard  # wayland
    xclip
    xsel
    xorg.xev
    xorg.xrandr
    xorg.xset
    xorg.xinput
    xdg-desktop-portal-gtk
    xdg-utils
    yq
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

  virtualisation.docker.enable = true;

  services.flatpak.enable = true;

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
