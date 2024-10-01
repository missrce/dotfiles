{
  lib,
  self,
  self',
  config,
  inputs,
  inputs',
  ...
}: let
  inherit (lib.modules) mkForce mkDefault;
  inherit (lib.attrsets) genAttrs;
in {
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit
        inputs
        self
        inputs'
        self'
        ;
    };

    users = genAttrs config.missos.system.users (name: ./${name});

    # we should define grauntied common modules here
    sharedModules = [
      {
        nix.package = mkForce config.nix.package;

        home.stateVersion = config.system.stateVersion;

        # reload system units when changing configs
        systemd.user.startServices = mkDefault "sd-switch"; # or "legacy" if "sd-switch" breaks again

        # let HM manage itself when in standalone mode
        programs.home-manager.enable = true;
      }
    ];
  };
}
