{
  pkgs,
  config,
  ...
}: let
  # inherit (lib.modules) mkForce;
  inherit (config.missos) device;
in {
  imports = [./fail2ban.nix];

  config = {
    # enable opensnitch firewall
    # inactive until opensnitch UI is opened
    services.opensnitch.enable = device.type != "server";

    networking.firewall = {
      enable = true;
      package = pkgs.iptables;

      allowedTCPPorts = [
        443
        8080
      ];
      allowedUDPPorts = [];

      # allow servers to be pinnged, but not our clients
      allowPing = device.type == "server";

      # make a much smaller and easier to read log
      logReversePathDrops = true;
      logRefusedConnections = false;

      # Don't filter DHCP packets, according to nixops-libvirtd
      # checkReversePath = mkForce false;
    };
  };
}
