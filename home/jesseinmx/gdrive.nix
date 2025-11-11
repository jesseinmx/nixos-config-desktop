{ config, pkgs, ... }:

{
  # Setup command: google-drive-ocamlfuse -label mcallister
  systemd.user.services.gdrive = {
    Unit = {
      Description = "Google Drive FUSE client (mcallister)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/gdrive-mcallister";
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -label mcallister %h/gdrive-mcallister";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/gdrive-mcallister";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Setup command: google-drive-ocamlfuse -label jesseinmx
  systemd.user.services.gdrive-jesseinmx = {
    Unit = {
      Description = "Google Drive FUSE client (jesseinmx)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/gdrive-jesseinmx";
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -label jesseinmx %h/gdrive-jesseinmx";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/gdrive-jesseinmx";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Setup command: google-drive-ocamlfuse -label flynn
  systemd.user.services.gdrive-flynn = {
    Unit = {
      Description = "Google Drive FUSE client (flynn)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/gdrive-flynn";
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -label flynn %h/gdrive-flynn";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/gdrive-flynn";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
