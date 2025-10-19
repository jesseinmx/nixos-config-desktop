{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "roo-cline";
        publisher = "rooveterinaryinc";
        version = "3.28.2";
        sha256 = "1prjjp4kh2g72gh3wcj38l6nzb55123m2w3a6fgkd12c2y6r4s79";
      }
    ]);
    profiles.default.userSettings = {
      "editor.fontFamily" = "Hack Nerd Font";
      "editor.minimap.enabled" = false;
      "roo-cline.allowedCommands" = [
        "git log"
        "git diff"
        "git show"
      ];
    };
  };
}
