{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) ghidra;
  inherit (lib.modules) mkIf;
  inherit (osConfig.missos.system.interface) graphical;

  inherit (osConfig.catppuccin) flavor;

  ghidraConfigDir = ".config/ghidra/${ghidra.distroPrefix}";

  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "ghidra";
    rev = "bed0999f96ee9869ed25e0f1439bef5eff341e22";
    hash = "sha256-mm7oxP8Fpn8PuyIgcsm6ZIfq11aEqqpzDL3FAF58ods=";
  };
  themeName = "catppuccin-${flavor}";
in {
  config = mkIf graphical {
    home.packages = [
      ghidra
    ];

    home = {
      file."${ghidraConfigDir}/themes/${themeName}.theme".text = builtins.readFile "${catppuccin}/themes/${themeName}.theme";
      file."${ghidraConfigDir}/preferences".text = ''
        GhidraShowWhatsNew=false
        SHOW.HELP.NAVIGATION.AID=true
        SHOW_TIPS=false
        TIP_INDEX=0
        Theme=File\:${config.home.homeDirectory}/${ghidraConfigDir}/themes/${themeName}.theme
        USER_AGREEMENT=ACCEPT
        ViewedProjects=
      '';
    };
  };
}
