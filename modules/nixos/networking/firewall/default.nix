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
      "iptable_nat"

      "nft_chain_nat"
      "nf_reject_ipv6"
      "nf_nat"

      "udp_diag"

      "xt_CHECKSUM"
      "xt_MASQUERADE"
      "xt_tcp"
      "xt_comment"
      "xt_multiport"
    ];
  };
}
