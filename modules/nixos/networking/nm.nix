{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.lists) optionals;

  inherit (config.missos) device system;
in {
  environment.systemPackages = optionals system.interface.graphical [
    pkgs.networkmanagerapplet # provides nm-connection-editor
  ];

  networking.networkmanager = {
    enable = true;
    plugins = mkForce [pkgs.networkmanager-openvpn];

    unmanaged = [
      "interface-name:tailscale*"
      "interface-name:br-*"
      "interface-name:rndis*"
      "interface-name:docker*"
      "interface-name:virbr*"
      "interface-name:vboxnet*"
      "interface-name:waydroid*"
      "type:bridge"
    ];

    wifi = {
      macAddress = "random"; # use a random mac address on every boot
      powersave = true;
      scanRandMacAddress = true; # MAC address randomization of a Wi-Fi device during scanning
    };

    ethernet.macAddress = mkIf (device.type != "server") "random"; # causes server to be unreachable over SSH
  };
}
