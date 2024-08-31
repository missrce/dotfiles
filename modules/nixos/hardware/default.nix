{
  imports = [
    ./bluetooth.nix # bluetooth
    ./firmware.nix # firmware
    ./options.nix # options to set the cpu and gpu
    ./tpm.nix # Trusted Platform Module
    ./yubikey.nix # yubikey device support and management tools
  ];
}
