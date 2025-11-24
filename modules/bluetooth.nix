{ config, pkgs, ... }:

{
  # 1. Enable the core Bluetooth stack (BlueZ)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # 2. Enable the Blueman graphical service for XFCE
  services.blueman.enable = true;

  # 3. (Optional but recommended for some devices) Allow input via BlueZ
  hardware.bluetooth.settings = {
    General = {
      # This setting can sometimes help with HID devices
      Enable = "Source,Sink,Media,Socket,Input";
    };
    Input = {
      # Explicitly enable Userspace HID for better compatibility
      UserspaceHID = true;
    };
  };
}
