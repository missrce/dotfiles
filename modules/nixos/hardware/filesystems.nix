{lib, ...}: {
  boot.supportedFilesystems.zfs = lib.modules.mkForce false;
}
