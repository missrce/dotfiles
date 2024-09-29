{config, pkgs, lib, ...}: {
  system = { 
    disableInstallerTools = true;
    switch = {
      enable = false;
      enableNg = true;
    };
  };

  environment.systemPackages = [
    config.system.build.nixos-rebuild
  ];

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };
}
