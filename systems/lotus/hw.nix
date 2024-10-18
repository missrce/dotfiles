# {
#   modulesPath,
#   inputs,
#   config,
#   pkgs,
#   lib,
#   ...
# }: {
#   imports = [
#     (modulesPath + "/installer/scan/not-detected.nix")
#     inputs.lanzaboote.nixosModules.lanzaboote
#     inputs.disko.nixosModules.disko
#     ./disko.nix
#   ];
#   zramSwap.enable = true;
#   services.fstrim.enable = true;
#   hardware.graphics = {
#     enable = true;
#     enable32Bit = true;
#   };
#   boot = {
#     kernelPackages = pkgs.linuxPackages_latest;
#     tmp.cleanOnBoot = true;
#     plymouth.enable = true;
#     lanzaboote = {
#       enable = true;
#       pkiBundle = "/etc/secureboot";
#       configurationLimit = 3;
#     };
#     loader = {
#       efi.canTouchEfiVariables = true;
#       # systemd-boot = {
#       #   enable = true;
#       #   configurationLimit = 3;
#       #   memtest86.enable = true;
#       # };
#       systemd-boot.enable = lib.modules.mkForce false;
#     };
#     initrd.systemd.enable = true;
#   };
#   services.power-profiles-daemon.enable = true;
#   hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
#   system.stateVersion = "24.11";
# }
# { config, lib, pkgs, modulesPath, ... }:
# {
#   imports =
#     [ (modulesPath + "/installer/scan/not-detected.nix")
#     ];
#   boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
#   boot.initrd.kernelModules = [ ];
#   boot.kernelModules = [ ];
#   boot.extraModulePackages = [ ];
#   # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
#   # (the default) this is the recommended approach. When using systemd-networkd it's
#   # still possible to use this option, but it's recommended to use it in conjunction
#   # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
#   networking.useDHCP = lib.mkDefault true;
#   # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
#   # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;
#   nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
#   hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
# }
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
    # inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  zramSwap.enable = true;
  services.fstrim.enable = true;

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
      };

      # systemd-boot.enable = lib.modules.mkForce false;
    };

    initrd.systemd.enable = true;
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.stateVersion = "24.11";
}
