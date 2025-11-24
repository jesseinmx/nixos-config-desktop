
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # General system packages
  environment.systemPackages = with pkgs; [

    # ndi #obs
    # obs-studio-plugins-wlrobs #obs studio plugin for wayland
    # obs-studio-plugins.obs-pixel-art
    # proton-ge-bin
    # wl-clipboard  # wayland
    abiword
    age
    aider-chat-with-browser
    alacritty
    appimage-run
    inputs.antigravity-nix.packages.${pkgs.system}.default
    arp-scan
    awscli
    bat
    bitwarden
    bitwarden-cli
    calibre
    cargo
    chezmoi
    chromium
    cifs-utils
    codex
    copyq
    curl
    deluge
    dig
    docker
    duplicacy
    easyeffects
    eza
    ffmpeg-full
    figlet
    file
    firefox
    flameshot
    freerdp
    fzf
    gemini-cli
    ghostty
    git
    git-open
    gnumeric
    go
    google-chrome
    google-drive-ocamlfuse
    granted
    kubernetes-helm
    home-manager
    htop
    i3
    i3lock
    i3status
    inkscape
    jq
    k9s
    kdePackages.kdenlive
    kitty
    kopia
    kopia-ui
    kubectl
    kustomize_4
    lazydocker
    lazygit
    logseq
    neovim
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
    netbird
    nmap
    nodePackages.aws-cdk
    nodePackages.npm
    nodejs
    obs-studio
    obs-studio-plugins.obs-3d-effect # missing in nix pkgs
    obs-studio-plugins.obs-backgroundremoval
    obs-studio-plugins.obs-composite-blur
    obs-studio-plugins.obs-gradient-source
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.obs-livesplit-one
    obs-studio-plugins.obs-move-transition
    obs-studio-plugins.obs-ndi
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.obs-replay-source
    obs-studio-plugins.obs-scale-to-sound
    obs-studio-plugins.obs-shaderfilter
    obs-studio-plugins.obs-source-clone
    obs-studio-plugins.obs-vaapi
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.waveform #obs
    obsidian
    packer
    pavucontrol
    pipewire
    podman
    protonplus
    protonup
    psmisc
    pulseaudio
    pyenv
    python3
    qpwgraph
    qutebrowser
    rclone
    remmina
    restic
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
    xclip
    xdg-desktop-portal-gtk
    xdg-utils
    xorg.xev
    xorg.xinput
    xorg.xrandr
    xorg.xset
    xsel
    yq-go
    zoxide # Provides 'z' command

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

  services.flatpak.packages = [
    # "com.obsproject.Studio"
    # "com.obsproject.Studio.Plugin.BackgroundRemoval"
    # "com.obsproject.Studio.Plugin.CompositeBlur"
    # "com.obsproject.Studio.Plugin.Gstreamer"
    # "com.obsproject.Studio.Plugin.MoveTransition"
    # "com.obsproject.Studio.Plugin.OBSLivesplitOne"
    # "com.obsproject.Studio.Plugin.OBSVkCapture"
    # "com.obsproject.Studio.Plugin.ScaleToSound"
    # "com.obsproject.Studio.Plugin.Shaderfilter"
    # "com.obsproject.Studio.Plugin.SourceClone"
    # "com.obsproject.Studio.Plugin._3DEffect"
    # "com.obsproject.Studio.Plugin.waveform"
    "com.github.tchx84.Flatseal"
    "com.usebottles.bottles"
    "de.z_ray.Facetracker"
    "io.github.Faugus.faugus-launcher"
    "net.lutris.Lutris"
    "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/24.08"
    "pro.vpup.vpuppr"
  ];

  # services.flatpak.overrides = {
  #   "com.obsproject.Studio" = {
  #     # Grants access to the entire host file system.
  #     # This is essentially turning the sandbox OFF.
  #     filesystems = "host";
  #     # You may also want to explicitly allow things like:
  #     # socket = [ "x11" "wayland" "pulseaudio" "pipewire" "system-bus" ];
  #     # devices = [ "all" ];
  #   };
  # };

  programs.steam.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

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
