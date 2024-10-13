{
  imports = [
    ./bluetooth.nix # bluetooth
    ./sound.nix # sound
    ./firmware.nix # firmware
    ./tpm.nix # Trusted Platform Module
    ./yubikey.nix # yubikey device support and management tools
    ./filesystems.nix # Filesystem support
  ];

  systemd.services.systemd-udev-settle.enable = false; # We do not need to wait for all hardware to initialise completely
}
