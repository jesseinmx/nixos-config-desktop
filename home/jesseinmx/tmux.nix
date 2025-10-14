{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    shell = "${pkgs.bash}/bin/bash";
    mouse = true;
    terminal = "screen-25jcolor";
    escapeTime = 10;
    keyMode = "vi";
    shortcut = "r"; # Use 'r' to reload tmux config

    # Declarative plugin management
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];

    # All other settings from tmux.conf
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g focus-events on

      # middle-click to paste from system clipboard
      bind-key -n MouseDown2Pane run "tmux set-buffer -b primary_selection \"$(xsel -o)\"; tmux paste-buffer -b primary_selection; tmux delete-buffer -b primary_selection"

      # name a pane after split
      bind-key c command-prompt -p "window name:" "new-window; rename-window '%%'"

      # split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # toggle synchronize-panes
      bind C-s setw synchronize-panes
      setw -g window-status-current-format '#{?pane_synchronized,#[bg=red],}#I:#W'
      setw -g window-status-format         '#{?pane_synchronized,#[bg=red],}#I:#W'

      # vim keys for pane selection (explicitly set)
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Pane menu for mouse right-click
      bind-key  -T root  MouseDown3Pane      display-menu -T "#[align=centre]#{pane_index} (#{pane_id})" -t = -x M -y M \
        ""                                                                                                                                     \
        "Toggle SyncPanes"                            S   "setw synchronize-panes"                                                   \
        "Swap Up"                                                       u   "swap-pane -U"                                                     \
        "Swap Down"                                                     d   "swap-pane -D"                                                     \
        "#{?pane_marked_set,,-}Swap Marked"                             s   swap-pane                                                          \
        ""                                                                                                                                     \
        Kill                                                            X   kill-pane                                                          \
        Respawn                                                         R   "respawn-pane -k"                                                  \
        "#{?window_zoomed_flag,Unzoom,Zoom}"                            z   "resize-pane -Z"
    '';
  };

  # Move tmux-related aliases here
  programs.bash.shellAliases = {
    t = "tty-clock -ct";
    tma = "tmux a";
    tmj = "tmux new -s jp \; split-window -v \; split-window -h \; select-pane -t 0 \;";
  };
}