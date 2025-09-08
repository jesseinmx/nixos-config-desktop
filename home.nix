# home.nix
{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";
  # ===== GNOME Dash-to-Dock (Auto-hide) — PACKAGES (START) =====
  # Installs the Dash-to-Dock extension so GNOME can use the dock.
  home.packages = [ pkgs.gnomeExtensions.dash-to-dock pkgs.gnome-screenshot pkgs.gnomeExtensions.penguin-ai-chatbot pkgs.gnomeExtensions.appindicator ];
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
      # click  | sloppy | mouse
      # sloppy = focus follows mouse without requiring entry/exit tracking precision
      # mouse  = similar, but stricter about pointer entering window
      focus-mode = "sloppy";
      # Raise the window after a short hover (optional, tweak the delay)
      auto-raise = false;
      auto-raise-delay = 200;  # milliseconds
      # Don’t force raising only on click (so hover raise can work)
      raise-on-click = true;
    };

    # ===== GNOME Dash-to-Dock (Auto-hide) — SETTINGS (START) =====
    "org/gnome/shell" = {
      # If you already enable other extensions elsewhere, include them in this list too.
      enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" "penguin-ai-chatbot@coffeecionado.gitlab.io" "appindicatorsupport@rgcjonas.gmail.com" ];

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "google-chrome.desktop"
        "virtualbox.desktop"
        "Alacritty.desktop"
        "kitty.desktop"
      ];

    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";  # or LEFT/RIGHT/TOP
      dock-fixed    = false;     # not fixed = can hide
      autohide      = true;      # hide until mouseover
      intellihide   = true;      # hide when windows overlap
      extend-height = false;     # keep it as a “dock” bar
      transparency-mode = "DYNAMIC";
      click-action  = "focus-or-appspread";
    };
    # ===== GNOME Dash-to-Dock (Auto-hide) — SETTINGS (END) =====

    # ===== Screenshot Keyboard Shortcuts (START) =====
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Screenshot area";
      command = "gnome-screenshot -a";
      binding = "<Super><Shift>1";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Screenshot window";
      command = "gnome-screenshot -w";
      binding = "<Super><Shift>2";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot full";
      command = "gnome-screenshot";
      binding = "<Super><Shift>3";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Record video";
      command = "dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.screencast.toggle();'";
      binding = "<Super><Shift>4";
    };
    # ===== Screenshot Keyboard Shortcuts (END) =====
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

}

