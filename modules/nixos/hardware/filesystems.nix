{lib, ...}: {
  boot.supportedFilesystems = lib.modules.mkForce ["ext4" "btrfs" "vfat" "ntfs"];
}
