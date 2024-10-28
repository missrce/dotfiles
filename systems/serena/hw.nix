{
  modulesPath,
  inputs,
  config,
  self',
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkDefault;
  # inherit (lib) sort concatStringsSep;

  # isSpecialisation = config.specialisation == {};
  isSpecialisation = false;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  zramSwap.enable = true;

  services = {
    fstrim.enable = true;
    btrfs.autoScrub.enable = true;
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
