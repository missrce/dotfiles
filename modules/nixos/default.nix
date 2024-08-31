{
  imports = [
    ./networking # network configuration
    ./security # NixOS hardening steps
    ./services # Services for the system and self hosting shenanigans
    ./hardware # Re-usable hardware configs
    ./environment # Environment stuff

    ./nix.nix # Modify Nix configuration
    ./catppuccin.nix # Catppuccin setup
  ];
}
