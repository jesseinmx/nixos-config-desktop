{ lib, pkgs, ... }:
let
  # Optional env toggle for vagrant provider; default to VirtualBox
  providerEnv = builtins.getEnv "FLYNN_VAGRANT_PROVIDER";
  provider     = if providerEnv != "" then providerEnv else "virtualbox";
in {
  # Vagrant CLI + Packer + helper wrapper to avoid user Ruby gems interference
  environment.systemPackages = with pkgs; [
    vagrant
    packer
    (writeShellScriptBin "vagrant-clean" ''
      exec env -u GEM_HOME -u GEM_PATH RUBYOPT="--disable-gems" vagrant "$@"
    '')
  ];

  # Default provider (allow host override)
  environment.variables.VAGRANT_DEFAULT_PROVIDER = lib.mkDefault provider;

  # Note: Packer plugins (e.g., vagrant, virtualbox) should be managed via
  # `required_plugins` in your .pkr.hcl and installed with `packer init`.
}
