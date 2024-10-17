let
  fileSystems = ["btrfs" "ext4" "vfat" "ntfs"];
in {
  boot = {
    supportedFilesystems = fileSystems;
    kernelModules = fileSystems;
  };
}
