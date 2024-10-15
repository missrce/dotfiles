{ lib, ... }:
{
  disko.devices.disk = lib.genAttrs [
    "nvme-WD_BLACK_SN850X_2000GB_22260N801935"
    "nvme-WD_BLACK_SN850X_2000GB_22302G804293"
    "nvme-WD_BLACK_SN850X_2000GB_22302G801012"
    "nvme-WD_BLACK_SN850X_2000GB_22302C801224"
  ] (id: {
    type = "disk";
    device = "/dev/disk/by-id/${id}";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["fmask=0077" "umask=0077"];
          };
        };
        mdadm = {
          size = "100%";
          content = {
            type = "mdraid";
            name = "raid0";
          };
        };
      };
    };
  });
  disko.devices.mdadm = {
    boot = {
      type = "mdadm";
      level = 0;
      metadata = "1.0";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };
    raid0 = {
      type = "mdadm";
      level = 0;
      content = {
        type = "luks";
        name = "crypted";
        askPassword = true;
        settings = {
          allowDiscards = true;
        };
        content = {
          type = "btrfs";
          extraArgs = ["-f"];
          subvolumes = {
            "/root" = {
              mountpoint = "/";
              mountOptions = ["compress=zstd" "noatime" "nodiratime"];
            };
            "/home" = {
              mountpoint = "/home";
              mountOptions = ["compress=zstd" "noatime" "nodiratime"];
            };
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = ["compress=zstd" "noatime" "nodiratime"];
            };
          };
        };
      };
    };
  };
}
