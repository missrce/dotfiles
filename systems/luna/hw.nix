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

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
      configurationLimit = 3;
    };

    loader = {
      efi.canTouchEfiVariables = true;

      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 3;
      #   netbootxyz.enable = true;
      #   memtest86.enable = true;
      # };

      systemd-boot.enable = lib.modules.mkForce false;
    };

    initrd.systemd.enable = true;
  };

  boot.initrd.luks.devices."luks_root".device = "/dev/disk/by-uuid/37a4bc2a-0892-492c-ae2d-d7cd312406a7";

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/B031-FEFC";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/" = {
      device = "/dev/mapper/luks_root";
      fsType = "btrfs";
      options = ["subvol=root" "noatime" "nodiratime"];
    };

    "/persistent" = {
      device = "/dev/mapper/luks_root";
      neededForBoot = true;
      fsType = "btrfs";
      options = ["subvol=persistent" "compress=zstd" "noatime" "nodiratime"];
    };

    "/nix" = {
      device = "/dev/mapper/luks_root";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime" "nodiratime"];
    };
  };

  boot.initrd.systemd.services.btrfsSetup = {
    description = "Setup BTRFS Temporary Directory";
    after = ["local-fs.target"]; # Ensure it runs after local filesystems are mounted
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        mkdir -p /btrfs_tmp
        mount /dev/mapper/luks_root /btrfs_tmp

        if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +1); do
          delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
  };

  services.power-profiles-daemon.enable = true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
