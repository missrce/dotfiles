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

    ./git.nix # the only version control system totally
    ./micro.nix # text editor nano but normal
    ./btop.nix # cool system monitor
    ./atuin.nix # shell history
    ./direnv.nix # manage your shell env based on repo
    ./hyfetch.nix # I use NixOS btw,
    ./bat.nix # cat with syntax highlighting
    ./fd.nix # user-friendly find
    ./freeze.nix # turn yo terminal and code into SVGs
    ./fzf.nix # command-line fuzzy finder
    ./eza.nix # modern reimplementation of ls
    ./zoxide.nix # smarter cd
    ./ripgrep.nix # modern grep
  ];

  home.packages = mkIf system.interface.graphical (
    mkMerge [
      # Packages for all graphical environments
      [pkgs.libnotify pkgs.brightnessctl]

      # Additional packages for WM environments
      (lib.mkIf environment.isWM [
        pkgs.wl-clipboard
        pkgs.cliphist
      ])
    ]
  );
}
