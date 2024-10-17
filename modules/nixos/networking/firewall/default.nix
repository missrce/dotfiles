{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkForce;
  inherit (config.missos) device;
in {
  imports = [./fail2ban.nix];

  config = {
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
      checkReversePath = mkForce false;
    };

    boot.kernelModules = [
      "ipt_REJECT"
      "ip6_tables"
      "nf_reject_ipv6"

      "xt_CHECKSUM"
      "xt_MASQUERADE"
    ];
  };
}
