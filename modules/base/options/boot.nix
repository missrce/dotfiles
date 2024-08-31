{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (config.missos) boot;
in {
  options.missos = {
    boot.secure = mkEnableOption ''Enable secure-boot, you must use something before hand like systemd-boot to get setup!'';
  };

  config = mkIf boot.secure {
    environment.systemPackages = [pkgs.sbctl];

    # Lanzaboote replaces the systemd-boot module.
    boot.loader.systemd-boot.enable = mkForce false;

    boot = {
      bootspec.enable = true;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
