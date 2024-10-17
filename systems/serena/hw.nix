{
  modulesPath,
  inputs,
  config,
  self',
  pkgs,
  lib,
  ...
}: let
  isUnstable = config.boot.zfs.package == pkgs.zfs_unstable;
  zfsCompatibleKernelPackages =
    lib.filterAttrs (
      name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name)
        != null
        && (builtins.tryEval kernelPackages).success
        && (
          (!isUnstable && !kernelPackages.zfs.meta.broken)
          || (isUnstable && !kernelPackages.zfs_unstable.meta.broken)
        )
    )
    pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  boot.zfs.package = pkgs.zfs_unstable;

  zramSwap.enable = true;

  services = {
    fstrim.enable = true;
    zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      open = true; # Enable the open source kernel modules

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = false;
        };

        nvidiaBusId = "PCI:01:00:0";
        amdgpuBusId = "PCI:16:00:0";
      };

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = false; # me when wayland

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = [self'.packages.nvidia-offload];

  boot = {
    kernelPackages = latestKernelPackage;
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
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

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
