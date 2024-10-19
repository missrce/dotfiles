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
    hash = "1faa4k4rfn35qnf7bpcf9jm7fbpmza5xj8dx24dpc6ychy5kk4zx";
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
