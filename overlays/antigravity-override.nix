# overlays/antigravity-override.nix
self: super: {
  google-antigravity = super.google-antigravity.overrideAttrs (oldAttrs: {
    fhs = super.buildFHSEnv {
      name = "antigravity-fhs";
      targetPkgs = pkgs: (oldAttrs.fhs.targetPkgs pkgs) ++ [ pkgs.sudo ];
      runScript = super.writeShellScript "antigravity-wrapper" ''
        # Set Chrome paths to use our wrapper that forces user profile
        # This ensures extensions installed in user's Chrome profile are available
        export CHROME_BIN=${oldAttrs.chrome-wrapper}
        export CHROME_PATH=${oldAttrs.chrome-wrapper}
        exec ${oldAttrs.antigravity-unwrapped}/lib/antigravity/antigravity --no-sandbox "$@"
      '';
      meta = oldAttrs.fhs.meta;
    };
  });
}
