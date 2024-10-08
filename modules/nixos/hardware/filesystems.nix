{lib, ...}: {
  boot.supportedFilesystems.zfs.enable = lib.modules.mkForce false;
}
