{
  config,
  pkgs,
  lib,
  ...
}: {
  zramSwap.enable = true;
  services.fstrim.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    plymouth = {
      enable = true;
      theme = "spinner";
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        netbootxyz.enable = true;
        memtest86.enable = true;
      };
    };
    initrd.systemd.enable = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B031-FEFC";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/" = {
    device = "UUID=2599b621-1dbb-4bf6-8fa0-8dd80b2814e0";
    fsType = "bcachefs";
    options = ["noatime" "nodiratime" "nofail"];
  };

  services.power-profiles-daemon.enable = true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
