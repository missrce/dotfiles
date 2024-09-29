{lib, ...}: {
  boot.supportedFilesystems = lib.modules.mkForce [ "bcachefs" "ext4" "btrfs" "vfat" "ntfs" ];
}
