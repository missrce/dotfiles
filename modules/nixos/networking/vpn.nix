{config, pkgs, ...}: {
  services.cloudflare-warp.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = if config.missos.system.interface.graphical then pkgs.mullvad-vpn else pkgs.mullvad;
  };
  networking.wireguard.enable = true;
  networking.iproute2.enable = true;
  networking.firewall.checkReversePath = "loose";
}
