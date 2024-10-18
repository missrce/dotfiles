# nvme-Seagate_FireCuda_SE_SSD_ZP1000GM30033_7VQ0284D
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-Seagate_FireCuda_SE_SSD_ZP1000GM30033_7VQ0284D";
        type = "disk";
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
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
