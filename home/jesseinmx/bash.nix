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
      less = "less -R";
      ll = "eza --long --header --git -lah";
      cz = "chezmoi";
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
      gq = "git status && git add . && git commit -m 'quick commit' && git push origin HEAD";
      oops = "git add -p && git commit --amend";
      lz = "lazygit";
      awswhoami = "aws sts get-caller-identity";
      cat = "bat --plain";
      chrome = "google-chrome-stable";
      s = "vim ~/scratch.md";
      agrep = "alias | rg ";
      envgrep = "env | rg -i ";
      rg = "rg --hidden -i";
      "vagrant-rdp" = "yes | xfreerdp /v/localhost:33389 /u/vagrant /p/vagrant &";
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      xfreerdp = "xfreerdp /dynamic-resolution ";
      tree = "tree -a";
      nixtest = "nix_test";
      nixapply = "(cd ~/nixos-config-desktop && sudo nixos-rebuild switch --flake .#JessBot)";
      orcaup = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml up -d";
      orcadown = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml down";
      "keepalive-bluetooth" = "(ffplay -nodisp -autoexit -loop 0 -volume 0 ~/silent.wav &> /dev/null &)";
      "bluetooth-keepalive" = "keepalive-bluetooth";
      "jwstream-sync" = "rclone sync -P jwstream:/jperry-renders ~/Videos/jwstream/";
      assume = ". assume";
    };

    initExtra = ''
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
          export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-file ~/.gitignore'
      elif type ag &> /dev/null; then
          export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
      fi
      if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
      fi
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
      [ -f $HOME/.profile.d/bethel.sh ] && source $HOME/.profile.d/bethel.sh
      cheat() { curl "https://cheat.sh/$*"; }
      flynn_browser() {
        qutebrowser &
        sleep 2
        wmctrl -r "Flynn's Browser" -e 0,-1,-1,1920,1080
      }
      nix_test() {
        (cd ~/nixos-config-desktop && nixos-rebuild build --flake .#JessBot)
        local status=$?
        if [ $status -ne 0 ]; then
          return $status
        fi
        local ans
        read -r -p "Apply changes now with nix-apply? [y/N] " ans || true
        if [[ "$ans" == [yY] ]]; then
          (cd ~/nixos-config-desktop && sudo nixos-rebuild switch --flake .#JessBot)
        else
          echo "Skip applying changes."
        fi
      }
      hometest() {
        (cd ~/nixos-config-desktop && home-manager switch --flake . --dry-run -b backup)
        local status=$?
        if [ $status -ne 0 ]; then
          return $status
        fi
        local ans
        read -r -p "Apply changes now with home-apply? [y/N] " ans || true
        if [[ "$ans" == [yY] ]]; then
          (cd ~/nixos-config-desktop && home-manager switch --flake . -b backup)
        else
          echo "Skip applying changes."
        fi
      }

      # This is a comment to separate the functions
      loadaws() {
        if [ -f ~/git/load-up-iam.sh ]; then
          . ~/git/load-up-iam.sh
        fi
      }
      [ -f ~/.profile.local ] && . ~/.profile.local
    '';
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

  programs.ssh = {
    enable = true;
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
