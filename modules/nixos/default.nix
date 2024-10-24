{
  imports = [
    ./networking # network configuration
    ./security # NixOS hardening steps
    ./services # Services for the system and self hosting shenanigans
    ./hardware # Re-usable hardware configs
    ./environment # Environment stuff
    ./dm # Display Manager configurations
    ./desktop # Desktop configs
    ./gaming # Gaming stuff

    ./packages # Some system-wide packages
    ./nix.nix # Modify Nix configuration
    ./catppuccin.nix # Catppuccin setup
  ];
}
