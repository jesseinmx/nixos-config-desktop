{ config, pkgs, lib, inputs, ... }:

let
  cfg = config.services.x2goserver;
in
{
  # Using upstream services.x2goserver.enable; apply overlay and extras when enabled

  config = lib.mkIf cfg.enable {
    # Overlay: patch x2goserver to remove dangling symlinks causing build failure
    nixpkgs.overlays = [
      (final: prev: {
        x2goserver = prev.x2goserver.overrideAttrs (old: {
          preFixup = (old.preFixup or "") + ''
            # Remove problematic version symlink if present
            if [ -L "$out/share/x2go/versions/VERSION.x2goserver-x2goagent" ]; then
              rm -f "$out/share/x2go/versions/VERSION.x2goserver-x2goagent"
            fi
            # Remove any x2goagent symlink under vendored nx-libs path inside $out
            find "$out" -path "*/lib/nx/bin/x2goagent" -type l -exec rm -f {} +
          '';
        });
      })
    ];
 
    # Install X2Go server component and X11 auth helper
    environment.systemPackages = with pkgs; [ x2goserver xorg.xauth ];

    # Ensure SSH port is open for X2Go transport
    services.openssh.openFirewall = lib.mkDefault true;
  };
}