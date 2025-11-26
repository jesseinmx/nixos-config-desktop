{ config, lib, ... }:

{
  options.jesse.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service for jesseinmx";
  };

  config = lib.mkIf config.jesse.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = "jesseinmx";
      dataDir = "/home/jesseinmx/Sync";
      guiAddress = "0.0.0.0:8384";
    };

    # Syncthing needs port 22000/tcp for sync protocol
    # and 21027/udp for discovery.
    networking.firewall = {
      allowedTCPPorts = [ 22000 8384 ];
      allowedUDPPorts = [ 21027 ];
    };
  };
}
