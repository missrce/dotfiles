{
  disko.devices = {
    disk = {
      # Devices will be mounted and formatted in alphabetical order, and btrfs can only mount raids
      # when all devices are present. So we define an "empty" luks device on the first disk,
      # and the actual btrfs raid on the second disk, and the name of these entries matters!
      disk1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_22260N801935";
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
            crypt_p1 = {
              size = "100%";
              content = {
                type = "luks";
                name = "p1"; # device-mapper name when decrypted
                askPassword = true;
                settings = {
                  allowDiscards = true;
                };
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_22302G804293";
        content = {
          type = "gpt";
          partitions = {
            crypt_p2 = {
              size = "100%";
              content = {
                type = "luks";
                name = "p2"; # device-mapper name when decrypted
                askPassword = true;
                settings = {
                  allowDiscards = true;
                };
              };
            };
          };
        };
      };
      disk3 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_22302G801012";
        content = {
          type = "gpt";
          partitions = {
            crypt_p3 = {
              size = "100%";
              content = {
                type = "luks";
                name = "p3"; # device-mapper name when decrypted
                askPassword = true;
                settings = {
                  allowDiscards = true;
                };
              };
            };
          };
        };
      };
      disk4 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_22302C801224";
        content = {
          type = "gpt";
          partitions = {
            crypt_p4 = {
              size = "100%";
              content = {
                type = "luks";
                name = "p4";
                askPassword = true;
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-d raid0"
                    "/dev/mapper/p1"
                    "/dev/mapper/p2"
                    "/dev/mapper/p3"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "rw"
                        "relatime"
                        "ssd"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
