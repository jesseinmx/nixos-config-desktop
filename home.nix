{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  home.sessionVariables.XCURSOR_SIZE = "28";

  # ===== GNOME Dash-to-Dock (Auto-hide) — PACKAGES (START) =====
  home.packages = [
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnome-screenshot
    pkgs.gnomeExtensions.penguin-ai-chatbot
    pkgs.gnomeExtensions.appindicator
    pkgs.wl-clipboard  # for wl-copy
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
      name = "Screenshot area";
      command = "bash -c 'NAME=\$(date +%Y%m%d-%H%M%S) && gnome-screenshot --area --file=${config.home.homeDirectory}/screenshots/screenshot-\$NAME.png && wl-copy < ${config.home.homeDirectory}/screenshots/screenshot-\$NAME.png'";
      binding = "<Alt><Shift>1";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Screenshot window";
      command = "bash -c 'NAME=\$(date +%Y%m%d-%H%M%S) && gnome-screenshot --window --file=${config.home.homeDirectory}/screenshots/screenshot-\$NAME.png && wl-copy < ${config.home.homeDirectory}/screenshots/screenshot-\$NAME.png'";
      binding = "<Alt><Shift>2";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot full";
      command = "gnome-screenshot --clipboard --interactive";
      binding = "<Alt><Shift>3";
    };

  #   "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
  #     name = "Record video";
  #     command = "dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.screencast.toggle();'";
  #     binding = "<Alt><Shift>4";
  #   };

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

}
