{ config, pkgs, lib, ... }:

{
  # Keep icons/cursors available system-wide (moved from [`desktop.nix`](desktop.nix:1))
  environment.pathsToLink = [ "/share/icons" "/share/cursors" ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
  };

  # Default desktop-manager toggles handled here for non-GNOME desktops.
  # Disable Enlightenment by default (moved from [`desktop.nix`](desktop.nix:1)).
  services.xserver.desktopManager.enlightenment.enable = false;

  # X11 input configuration
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
    mouse = {
      naturalScrolling = true;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable xrdp
  services.xrdp = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.syncthing.enable = true;

  # # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "jesseinmx";

  # Workaround for GNOME autologin moved to ./modules/gnome.nix
  # See: ./modules/gnome.nix for GNOME-specific systemd tweaks

  # gnome-keyring is a standard for libsecret used by vscode
  services.gnome.gnome-keyring.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    openFirewall = true;
    
    # Use the 'settings' block with the new type (list of strings)
    settings = {
      # This setting replaces the default list entirely.
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
        "hmac-sha2-512"
        "hmac-sha2-256"
        "umac-128@openssh.com"
        "hmac-sha1-etm@openssh.com"
        "hmac-sha1"
        "hmac-md5-etm@openssh.com"
        "hmac-md5"
      ];
    };
  };

  # X2Go server
  services.x2goserver.enable = true;
  
}
