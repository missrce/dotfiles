{
  imports = [
    ./bluetooth.nix # bluetooth
    ./sound.nix # sound
    ./firmware.nix # firmware
    ./tpm.nix # Trusted Platform Module
    ./yubikey.nix # yubikey device support and management tools
  ];
}
