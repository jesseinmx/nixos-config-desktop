{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true; # Ensure bash is enabled for these aliases
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
      gq = "git status && git add . && git commit -m \"quick commit\" && git push origin HEAD";
      oops = "git add -p && git commit --amend";

      # lazygit
      lz = "lazygit";

      # AWS
      awswhoami = "aws sts get-caller-identity";
      # loadaws will be a function in initExtra

      # bat/batcat
      cat = "bat --plain";
      # alias less=\"bat\" - this would override the less -R alias. I'll keep the less -R for now.

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
      # vagrant is commented out in original
      "vagrant-rdp" = "yes | xfreerdp /v:localhost:33389 /u:vagrant /p:vagrant &";

      # xclip (X11 clipboard utilities - pbcopy/pbpaste equivalents)
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";

      # xfreerdp
      xfreerdp = "xfreerdp /dynamic-resolution ";

      # tree
      tree = "tree -a";

      # NixOS
      "nix-test" = "nix_test"; # This will be a function
      "nix-apply" = "(cd ~/nixos-config-desktop && sudo nixos-rebuild switch --flake .)";

      # Orca Slicer
      orcaup = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml up -d";
      orcadown = "docker compose --file ~/git/jesseinmx/orcaslicer/docker-compose.yaml down";

      # Bluetooth
      "keepalive-bluetooth" = "(ffplay -nodisp -autoexit -loop 0 -volume 0 ~/silent.wav &> /dev/null &)";
      "bluetooth-keepalive" = "keepalive-bluetooth";

      # rclone
      "jwstream-sync" = "rclone sync -P jwstream:/jperry-renders ~/Videos/jwstream/";
    };

    initExtra = ''
      # Functions from original aliases
      cheat() { curl "https://cheat.sh/$*"; }

      flynn_browser() {
        # Launch qutebrowser in the background
        qutebrowser &

        # Wait 2 seconds for the window to appear
        sleep 2

        # Find the window and resize it
        wmctrl -r "Flynn's Browser" -e 0,-1,-1,1920,1080
      }

      # NixOS function
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

      # AWS loadaws function
      loadaws() {
        . ~/git/load-up-iam.sh
      }

      # Source bethel scripts
      source /home/jesseinmx/.profile.d/bethel.sh
    '';
  };
}
