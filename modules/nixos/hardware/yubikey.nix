{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in {
  options.missos.system.yubikeySupport = {
    enable = mkEnableOption "yubikey support";
  };

  config = mkIf config.missos.system.yubikeySupport.enable {
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
    environment.systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        yubikey-manager # cli
        yubikey-manager-qt # gui
        ;
    };
  };
}
