{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkMerge mkIf;

  inherit (osConfig.missos) system environment;
in {
  imports = [
    ./shell # different shells

    ./atuin.nix # shell history
    ./hyfetch.nix # I use NixOS btw,
    ./bat.nix # cat with syntax highlighting
    ./fd.nix # user-friendly find
    ./freeze.nix # turn yo terminal and code into SVGs
    ./fzf.nix # command-line fuzzy finder
  ];

  home.packages = mkIf system.interface.graphical (
    mkMerge [
      # Packages for all graphical environments
      [pkgs.libnotify]

      # Additional packages for WM environments
      (lib.mkIf environment.isWM [
        pkgs.wl-clipboard
        pkgs.cliphist
      ])
    ]
  );
}
