{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;
  inherit (lib.types) bool;
  inherit (lib.options) mkOption;
in {
  options.missos.system.yubikeySupport = mkOption {
    type = bool;
    default = false;
    description = "yubikey support";
  };

  config = mkIf config.missos.system.yubikeySupport {
    hardware.gpgSmartcards.enable = true;

    services = {
      pcscd.enable = true;
      udev.packages = [pkgs.yubikey-personalization];
    };

    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    # Yubico's official tools
    environment.systemPackages = with pkgs;
      [
        yubikey-manager
      ]
      ++ optionals config.missos.system.interface.graphical [
        pkgs.yubikey-manager-qt
      ];
  };
}
