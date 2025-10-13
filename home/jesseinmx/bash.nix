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
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellOptions = [ "histappend" ];
    historyControl = [ "ignoredups" "erasedups" ];
    historySize = 10000;
    historyFileSize = 10000;

    shellAliases = {
      # General
      less = "less -R";

      # eza
      ll = "eza --long --header --git -lah";

      # chezmoi
      cz = "chezmoi";

      # Git (minimal)
      gs = "git status";
      gclean = "git clean -df";
      gco = "git checkout";
      gcm = "git checkout master || git checkout main";
      gpu = "git pull --ff-only";
      gf = "git fetch";
      ga = "git add -p";
      gb = "git branch";
      gc = "git commit";
      gpof = "git push --force-with-lease origin HEAD";
      gpo = "git push origin HEAD";
      gpos = "git push -o ci.skip";
      gq = "git status && git add . && git commit -m "quick commit" && git push origin HEAD";
      oops = "git add -p && git commit --amend";

      # lazygit
      lz = "lazygit";

      # AWS
      awswhoami = "aws sts get-caller-identity";

      # bat/batcat
      cat = "bat --plain";

      # Chrome
      chrome = "google-chrome-stable";

      # Vim
      v = "nvim";
      vim = "nvim";
      vi = "nvim -u /dev/null";
      s = "vim ~/scratch.md";

      # Ripgrep
      agrep = "alias | rg ";
      envgrep = "env | rg -i ";
      rg = "rg --hidden -i";

      # Tmux
      t = "tty-clock -ct";
      tma = "tmux a";
      tmj = "tmux new -s jp \; split-window -v \; split-window -h \; select-pane -t 0 \;";

      # Vagrant
      "vagrant-rdp" = "yes | xfreerdp /v:localhost:33389 /u:vagrant /p:vagrant &";

      # xclip (X11 clipboard utilities - pbcopy/pbpaste equivalents)
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";

      # xfreerdp
      xfreerdp = "xfreerdp /dynamic-resolution ";

      # tree
      tree = "tree -a";

      # NixOS
      nixtest = "nix_test"; # This will be a function
      nixapply = "(cd ~/nixos-config-desktop && sudo nixos-rebuild switch --flake .)";

      # Orca Slicer
      orcaup = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml up -d";
      orcadown = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml down";

      # Bluetooth
      "keepalive-bluetooth" = "(ffplay -nodisp -autoexit -loop 0 -volume 0 ~/silent.wav &> /dev/null &)";
      "bluetooth-keepalive" = "keepalive-bluetooth";

      # rclone
      "jwstream-sync" = "rclone sync -P jwstream:/jperry-renders ~/Videos/jwstream/";

      # From default.nix
      assume = ". assume";
      
    };

    initExtra = '''
      # --- Settings from former default.nix ---
      export BMA_HOME="${bash-my-aws}"
      export PATH="$PATH:$BMA_HOME/bin"
      source "$BMA_HOME/aliases"
      source "$BMA_HOME/bash_completion.sh"

      set -o vi
      export PROMPT_COMMAND="history -a; history -n"
      if command -v tput >/dev/null && tput setaf 1 >/dev/null 2>&1; then
          PS1="\[$(tput setaf 39)\]\u\[$(tput setaf 81)\]@\[$(tput setaf 77)\]\h \[$(tput setaf 226)\]\w \[$(tput sgr0)\]$ "
      fi

      export GPG_TTY=$(tty)

      if type rg &> /dev/null; then
          export FZF_DEFAULT_DEFAULT_COMMAND='rg --files --hidden --ignore-file ~/.gitignore'
      elif type ag &> /dev/null; then
          export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
      fi

      if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
      fi

      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
      [ -f $HOME/.profile.d/bethel.sh ] && source $HOME/.profile.d/bethel.sh

      # --- Functions from former aliases.nix ---
      cheat() { curl "https://cheat.sh/$*"; }

      flynn_browser() {
        # Launch qutebrowser in the background
        qutebrowser &

        # Wait 2 seconds for the window to appear
        sleep 2

        # Find the window and resize it
        wmctrl -r "Flynn's Browser" -e 0,-1,-1,1920,1080
      }

      nix_test() {
        # Run test (dry-activate) without changing current shell directory
        (cd ~/nixos-config-desktop && nixos-rebuild dry-build)
        local status=$?
        if [ $status -ne 0 ]; then
          return $status
        fi

        # Ask to apply (no timeout)
        local ans
        read -r -p "Apply changes now with nix-apply? [y/N] " ans || true
        if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
          (cd ~/nixos-config-desktop && sudo nixos-rebuild switch --flake .)
        else
          echo "Skip applying changes."
        fi
      }

      loadaws() {
            . ~/git/load-up-iam.sh
          }

          # --- From .bashrc integration ---
          # Source a local, non-managed aliases file if it exists for quick overrides
          [ -f ~/.aliases ] && . ~/.aliases

          # --- From .bash_profile integration ---
          # Source a local, non-managed profile for login-specific settings
          [ -f ~/.profile.local ] && . ~/.profile.local
    ''';
  };

  

  programs.pyenv = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
