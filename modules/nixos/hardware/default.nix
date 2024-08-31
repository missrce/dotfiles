{
  imports = [
    ./media # sound and video

    ./bluetooth.nix # bluetooth
    ./firmwares.nix # firmwares
    ./options.nix # options to set the cpu and gpu
    ./tpm.nix # Trusted Platform Module
    ./yubikey.nix # yubikey device support and management tools
  ];
}
