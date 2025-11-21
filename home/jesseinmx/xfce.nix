{ config, pkgs,... }:

{
 
  xfconf.settings = {
    "xfce4-keyboard-shortcuts" = {
      
      # This ensures custom commands take precedence
      "commands/custom/override" = true;
      "xfwm4/custom/override" = true;
      
      # Optional: Neutralizing a potential conflicts
      "xfwm4/custom/<Super>d" = null;
      "xfwm4/custom/<Super>space" = null;
      "xfwm4/default/<Primary><Alt>Right" = null;
      
      # New stable binding: Map Super + Space to the Whisker Menu
      "commands/custom/<Super>space" = "xfce4-popup-whiskermenu";

      # Screenshots (flameshot) — see [`home/jesseinmx/kybd_shortcuts.md`](home/jesseinmx/kybd_shortcuts.md:7)
      "commands/custom/<Alt><Shift>exclam" = "flameshot gui -p ${config.home.homeDirectory}/screenshots -c";
      "commands/custom/<Alt><Shift>at" = "flameshot screen -p ${config.home.homeDirectory}/screenshots -c";
      "commands/custom/<Alt><Shift>numbersign" = "flameshot full -p ${config.home.homeDirectory}/screenshots -c";

      # # Media keys
      "commands/custom/XF86AudioRaiseVolume" = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
      "commands/custom/XF86AudioLowerVolume" = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
      "commands/custom/XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
 
      # Workspaces navigation — see [`home/jesseinmx/keybindings.md`](home/jesseinmx/keybindings.md:41)
      "xfwm4/custom/<Ctrl><Alt>Right" = "right_workspace_key";
      "xfwm4/custom/<Ctrl><Alt>Left" = "left_workspace_key";
      
      # Window Management
      "commands/custom/<Ctrl><Alt>Up" = "xfdesktop --windowlist";
      "xfwm4/custom/<Alt>F4" = "close_window_key";
    
    };

    "xfwm4" = {
      "general/focus_mode" = "sloppy";
      "general/auto_raise" = false;
      "general/raise_with_viewports" = 1;
    };
    
  };
}