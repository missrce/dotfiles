{
  modulesPath,
  inputs,
  config,
  self',
  pkgs,
  lib,
  ...
}: let
  inherit (lib.attrsets) filterAttrs;
  inherit (lib.modules) mkDefault;
  inherit (lib.strings) versionOlder;
  inherit (lib.lists) last;
  # inherit (lib) sort concatStringsSep;
  inherit (lib) sort;

  isUnstable = config.boot.zfs.package == pkgs.zfs_unstable;
  zfsCompatibleKernelPackages =
    filterAttrs (
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
  latestKernelPackage = last (
    sort (a: b: (versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
  # isSpecialisation = config.specialisation == {};
  isSpecialisation = false;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # inputs.lanzaboote.nixosModules.lanzaboote
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
    xserver.videoDrivers =
      if !isSpecialisation
      then ["nvidia"]
      else [];
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia = {
      # Modesetting is required.
      modesetting.enable = false;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = true;
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      open = true; # Enable the open source kernel modules

      prime = {
        offload = {
          enable = !isSpecialisation;
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

  environment.systemPackages =
    if !isSpecialisation
    then [self'.packages.nvidia-offload]
    else [];

  # specialisation.vfio = {
  #   inheritParentConfig = true;
  #   configuration = let
  #     iommuDeviceIDs = [
  #       "10de:2684" # VGA 01:00.0
  #       "10de:22ba" # Audio 01:00.1
  #     ];
  #   in {
  #     # services.udev.extraRules = ''
  #     #   SUBSYSTEM=="kvmfr", OWNER="${config.missos.system.mainUser}", GROUP="kvm", MODE="0660"
  #     # '';
  #     boot = {
  #       kernelParams = [
  #         ("vfio-pci.ids=" + concatStringsSep "," iommuDeviceIDs)
  #       ];
  #       # extraModulePackages = with config.boot.kernelPackages; [kvmfr];
  #       # extraModprobeConfig = ''
  #       #   options kvmfr static_size_mb=128
  #       # '';
  #       kernelModules = [
  #         "vfio_pci"
  #         "vfio"
  #         "vfio_iommu_type1"
  #       ];
  #     };
  #   };
  # };

  boot = {
    kernelPackages = latestKernelPackage;
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
        # configurationLimit = 3;
        memtest86.enable = true;
      };

      # systemd-boot.enable = mkForce false;
    };

    initrd.systemd.enable = true;
  };

  hardware.cpu.amd.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
