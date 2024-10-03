{
  modulesPath,
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
  ];

  zramSwap.enable = true;
  services.fstrim.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    plymouth.enable = true;

    # lanzaboote = {
    #   enable = true;
    #   pkiBundle = "/etc/secureboot";
    #   configurationLimit = 3;
    # };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        netbootxyz.enable = true;
        memtest86.enable = true;
      };

      # systemd-boot.enable = lib.modules.mkForce false;
    };

    initrd.systemd.enable = true;
  };

  disko.devices = {
    disk = {
      vdb = {
        device = "/dev/disk/by-id/nvme-Seagate_FireCuda_SE_SSD_ZP1000GM30033_7VQ02747";
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
            luks = {
              size = "100%";
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
        };
      };
    };
  };

  services.power-profiles-daemon.enable = true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
