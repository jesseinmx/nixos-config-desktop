{ config, pkgs, ... }:

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}