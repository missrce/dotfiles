{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  system = {
    disableInstallerTools = true;
    switch = {
      enable = false;
      enableNg = true; # We only need this if NH is disabled
    };
  };

  environment.systemPackages = [
    config.system.build.nixos-rebuild
  ];

  system.activationScripts.diff = mkIf (!config.programs.nh.enable) {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        echo "=== diff to current-system ==="
        ${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
        echo "=== end of the system diff ==="
      fi
    '';
  };
}
