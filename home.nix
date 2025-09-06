# home.nix
{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

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
      auto-raise = true;
      auto-raise-delay = 400;  # milliseconds

      # Don’t force raising only on click (so hover raise can work)
      raise-on-click = false;
    };

  };
}

