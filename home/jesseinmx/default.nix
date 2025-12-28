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
    ./ghostty.nix
    ./gdrive.nix
    ./i3.nix
    ./neovim.nix
    ./tmux.nix
    ./vscode.nix
    # ./gnome.nix
    ./xfce.nix
  ];

  home.username = "jesseinmx";
  home.homeDirectory = "/home/jesseinmx";
  home.stateVersion = "25.05";

  # add containers policy for gitlab deploy script
  home.file.".config/containers/policy.json".text = builtins.toJSON {
    default = [{
      type = "insecureAcceptAnything";
    }];
  };

  

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
    # SOPS_AGE_KEY_FILE = "$HOME/.sops/nebula.age";
    # SOPS_AGE_RECIPIENTS = "age104xn5xt46wgg3n27em955qm9wkdwrxafx4crtqgq2fzz6zfn3s7slskqwt";
    VAGRANT_DEFAULT_PROVIDER = "virtualbox";
  };

  
  # GTK bookmarks 

  xdg.configFile."gtk-3.0/bookmarks" = {
    text = ''
      file://${config.home.homeDirectory}/ Home
      file://${config.home.homeDirectory}/Downloads Downloads
      file://${config.home.homeDirectory}/Documents Documents
      file://${config.home.homeDirectory}/Pictures Pictures
      file://${config.home.homeDirectory}/Desktop Desktop
      file://${config.home.homeDirectory}/Videos Videos
      file://${config.home.homeDirectory}/Videos/obs-raw obs-raw
      file://${config.home.homeDirectory}/flynn/video Flynn-Video
      file://${config.home.homeDirectory}/flynn/docs Flynn-Docs
      file://${config.home.homeDirectory}/flynn/graphics Flynn-Graphics
      file://${config.home.homeDirectory}/git git
      file://${config.home.homeDirectory}/gdrive-flynn G-Flynn
      file://${config.home.homeDirectory}/gdrive-jesseinmx G-JesseInMX
      file://${config.home.homeDirectory}/gdrive-mcallister G-Mcallister
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

  services.easyeffects = {
    enable = true;
    preset = "NoisReduction"; # optional
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ~/.ssh/jesseinmx-dev
      IdentityFile ~/.ssh/id_bethel
    '';
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/jesseinmx-dev";
      };
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
