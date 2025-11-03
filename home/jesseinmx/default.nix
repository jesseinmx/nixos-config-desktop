{ config, pkgs, ... }:
let
  bash-my-aws = pkgs.fetchFromGitHub {
    owner = "bash-my-aws";
    repo = "bash-my-aws";
    rev = "master";
    sha256 = "sha256-NkTCrbv3p65xuxltYQCNArIMsjBksz5rzoYbdPdCB3s=";
  };
in
{
  imports = [
    ./bash.nix
    ./i3.nix
    ./neovim.nix
    ./tmux.nix
    ./vscode.nix
  ];

  home.username = "jesseinmx";
  home.homeDirectory = "/home/jesseinmx";
  home.stateVersion = "25.05";

  

  home.sessionVariables = {
    XCURSOR_SIZE = "28";
    # Force X11 for applications that might default to Wayland
    GDK_BACKEND = "x11";
    QT_QPA_PLATFORM = "xcb";
    SDL_VIDEODRIVER = "x11";
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # From .bash_profile
    EDITOR = "vi";
    VISUAL = "nvim";
    MYVIMRC = "$HOME/.config/nvim/init.vim";
    TERM = "xterm-256color";
    BMA_COLUMNISE_ONLY_WHEN_TERMINAL_PRESENT = "true";
    BASH_SILENCE_DEPRECATION_WARNING = "1";
    GOPATH = "$HOME/go";
    GOBIN = "$GOPATH/bin";
    GO111MODULE = "auto";
    VAULT_USER = "jperry2";
    AWS_VAULT_USER = "jperry2";
    SOPS_AGE_KEY_FILE = "$HOME/.sops/nebula.age";
    SOPS_AGE_RECIPIENTS = "age104xn5xt46wgg3n27em955qm9wkdwrxafx4crtqgq2fzz6zfn3s7slskqwt";
    VAGRANT_DEFAULT_PROVIDER = "virtualbox";
  };

  # ===== GNOME Dash-to-Dock (Auto-hide) — PACKAGES (START) =====
  home.packages = [
    pkgs.flatseal
    pkgs.gnome-screenshot
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.easyeffects-preset-selector
    pkgs.gnomeExtensions.search-light
    pkgs.gnomeExtensions.tiling-shell
    pkgs.gnomeExtensions.x11-gestures
    # pkgs.wl-clipboard  # for wl-copy  # wayland
    
    
    
    
    
  ];
  # ===== GNOME Dash-to-Dock (Auto-hide) — PACKAGES (END) =====

  

  # GNOME per-user settings via dconf
  # NOTE: Do NOT set programs.dconf.enable here — it's not defined in your HM module set.
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    # ➜ Focus follows mouse ("hover to focus")
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = false;
      auto-raise-delay = 200;  # milliseconds
      raise-on-click = true;
    };
    # ===== GNOME Dash-to-Dock (Auto-hide) — SETTINGS (START) =====
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "penguin-ai-chatbot@coffeecionado.gitlab.io"
        "appindicatorsupport@rgcjonas.gmail.com"
	"search-light@icedman.github.com"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "google-chrome.desktop"
        "virtualbox.desktop"
        "Alacritty.desktop"
        "kitty.desktop"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      autohide = true;
      intellihide = true;
      extend-height = false;
      transparency-mode = "DYNAMIC";
      click-action = "focus-or-appspread";
    };
    # ===== GNOME Dash-to-Dock (Auto-hide) — SETTINGS (END) =====

    # Custom screenshot shortcuts
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Screenshot area (flameshot)";
      # The -p flag saves to the path, and the -c flag copies to the clipboard
      command = "flameshot gui -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>1";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Screenshot screen (flameshot)";
      # The -p flag saves to the path, and the -c flag copies to the clipboard
      command = "flameshot screen -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>2";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot full (flameshot)";
      # The -p flag saves to the path, and the -c flag copies to the clipboard
      command = "flameshot full -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>3";
    };

  #   "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
  #     name = "Record video";
  #     command = "dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:\'Main.screencast.toggle();\'";
  #     binding = "<Alt><Shift>4";
  #   };

    "org/gnome/nautilus/preferences" = {
      "always-use-location-entry" = true;
    };

  };

  xdg.configFile."gtk-3.0/bookmarks" = {
    text = ''
      file://${config.home.homeDirectory}/ Home
      file://${config.home.homeDirectory}/Downloads Downloads
      file://${config.home.homeDirectory}/git git
      file://${config.home.homeDirectory}/Insync Insync
      file://${config.home.homeDirectory}/Desktop Desktop
      file://${config.home.homeDirectory}/Pictures Pictures
      file://${config.home.homeDirectory}/Videos Videos
      file://${config.home.homeDirectory}/Documents Documents
      file://${config.home.homeDirectory}/nixos-config-desktop nixos-config
      file://${config.home.homeDirectory}/vagrant vagrant
    '';
  };

  # --- START: systemd user service for ffplay ---
  systemd.user.services."keep-audio-active" = {
    Unit = {
      Description = "Keep audio device active by playing silence";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.bash}/bin/sh -c "${pkgs.ffmpeg}/bin/ffplay -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -volume 0 -autoexit -loop 0 -nodisp > /dev/null 2>&1"
      '';
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  # --- END: systemd user service for ffplay ---

  

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "10.1.1.*" = {
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };
      "192.168.88.*" = {
        extraOptions = {
          StrictHostKeyChecking = "no";
        };
      };
    };
  };

  

  

  }
