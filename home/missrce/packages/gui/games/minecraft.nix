{ osConfig, pkgs, lib, ... }: let
  inherit (lib.lists) optionals;
in {
  home.packages = optionals osConfig.missos.programs.games.minecraft [
    pkgs.prismlauncher
  ];
}
