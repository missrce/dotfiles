let
  fileSystems = ["btrfs" "ext4" "bcachefs" "vfat" "ntfs"];
in {
  boot = {
    supportedFilesystems = fileSystems;
    kernelModules = fileSystems;
  };
}
