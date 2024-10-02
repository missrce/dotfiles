{
  imports = [
    ./documentation.nix # nixos' provided documentation
    ./locale.nix # locale settings
    ./zram.nix # zram optimisation and enabling
    ./gpg.nix # enable correct service for graphical interfaces
  ];
}
