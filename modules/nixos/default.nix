{
  imports = [
    ./networking # network configuration
    ./security # NixOS hardening steps

    ./nix.nix # Modify Nix configuration
    ./catppuccin.nix # Catppuccin setup
  ];
}
