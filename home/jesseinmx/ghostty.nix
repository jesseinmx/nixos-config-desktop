{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.5;
    };
  };
}
