{pkgs, lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum;
  inherit (lib.modules) mkDefault;
in {
  imports = [
    ./autologin.nix
    ./gdm.nix
  ];

  options.missos.environment.loginManager = mkOption {
    type = nullOr (enum [
      "autologin"
      "getty"
      "gdm"
    ]);
    default = "gdm";
    description = "The display manager to be used by the system.";
  };

  # No more (e)xterm(inator)

  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # If the config is inside of a VM, we want to autologin as security is not the upmost concern.

  config.virtualisation.vmVariant.missos.environment.loginManager = mkDefault "autologin";
}
