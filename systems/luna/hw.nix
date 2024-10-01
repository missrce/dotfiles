{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

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

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B031-FEFC";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/48608c0f-01df-414b-b500-e6ff2af2f1d0";
    fsType = "bcachefs";
    options = ["noatime" "nodiratime" "nofail"];
  };

  services.power-profiles-daemon.enable = true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
