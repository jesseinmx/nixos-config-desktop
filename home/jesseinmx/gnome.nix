{ config, pkgs, ... }:
{
  # GNOME-related packages
  home.packages = [
    pkgs.gnome-screenshot
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.easyeffects-preset-selector
    pkgs.gnomeExtensions.search-light
    pkgs.gnomeExtensions.tiling-shell
    pkgs.gnomeExtensions.x11-gestures
  ];

  # GNOME per-user settings via dconf
  # NOTE: Do NOT set programs.dconf.enable here — it's not defined in your HM module set.
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      auto-raise = false;
      auto-raise-delay = 200;
      raise-on-click = true;
    };

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
        "ghostty.desktop"
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

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Screenshot area (flameshot)";
      command = "flameshot gui -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>1";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Screenshot screen (flameshot)";
      command = "flameshot screen -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>2";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot full (flameshot)";
      command = "flameshot full -p ${config.home.homeDirectory}/screenshots -c";
      binding = "<Alt><Shift>3";
    };

    "org/gnome/nautilus/preferences" = {
      "always-use-location-entry" = true;
    };
  };

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
}