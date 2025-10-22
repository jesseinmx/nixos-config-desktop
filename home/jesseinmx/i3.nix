{ config, pkgs, ... }:

{
  home.packages = [ pkgs.rofi ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      keybindings = {
        "Mod1+Return" = "nop";
        "$mod+Return" = "exec alacritty";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "$mod+d" = "exec rofi -show drun";
        "$mod+h" = "focus left";
        "$mod+j" = "focus down";
        "$mod+k" = "focus up";
        "$mod+l" = "focus right";
        "$mod+Shift+h" = "move left";
        "$mod+Shift+j" = "move down";
        "$mod+Shift+k" = "move up";
        "$mod+Shift+l" = "move right";
        "$mod+v" = "split v";
        "$mod+s" = "split h";
        "$mod+e" = "layout toggle split";
        "$mod+w" = "layout tabbed";
        "$mod+t" = "layout stacking";
        "$mod+f" = "fullscreen toggle";
        "$mod+Shift+space" = "floating toggle";
        "$mod+q" = "kill";
        "$mod+Shift+r" = "restart";
        "$mod+r" = "reload";
        "$mod+Shift+e" = "exec i3-msg exit";
        "$mod+1" = "workspace number 1";
        "$mod+2" = "workspace number 2";
        "$mod+3" = "workspace number 3";
        "$mod+4" = "workspace number 4";
        "$mod+5" = "workspace number 5";
        "$mod+6" = "workspace number 6";
        "$mod+7" = "workspace number 7";
        "$mod+8" = "workspace number 8";
        "$mod+9" = "workspace number 9";
        "$mod+0" = "workspace number 10";
        "$mod+Shift+1" = "move container to workspace number 1";
        "$mod+Shift+2" = "move container to workspace number 2";
        "$mod+Shift+3" = "move container to workspace number 3";
        "$mod+Shift+4" = "move container to workspace number 4";
        "$mod+Shift+5" = "move container to workspace number 5";
        "$mod+Shift+6" = "move container to workspace number 6";
        "$mod+Shift+7" = "move container to workspace number 7";
        "$mod+Shift+8" = "move container to workspace number 8";
        "$mod+Shift+9" = "move container to workspace number 9";
        "$mod+Shift+0" = "move container to workspace number 10";
        "Control+Mod1+Left" = "workspace prev";
        "Control+Mod1+Right" = "workspace next";
      };
    };

    };
}