{ config, pkgs, ... }:

{
  # Enable the neovim program and manage it via home-manager
  programs.neovim = {
    enable = true;
  };

  # Set environment variables for neovim
  home.sessionVariables = {
    VISUAL = "nvim";
    MYVIMRC = "$HOME/.config/nvim/init.vim";
  };

  # Set bash aliases for neovim
  programs.bash.shellAliases = {
    v = "nvim";
    vim = "nvim";
    vi = "nvim -u /dev/null";
  };
}
