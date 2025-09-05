# home.nix
# This is the minimal configuration to enable natural (reversed) mouse scrolling.

{ config, pkgs, ... }:

{
  # This line is crucial for Home Manager to know which version of
  # options and defaults to use. It should match your system.stateVersion.
  home.stateVersion = "25.05";
}

