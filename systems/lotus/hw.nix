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
    ./disko.nix
  ];

  zramSwap.enable = true;
  services.fstrim.enable = true;

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
      # };

      systemd-boot.enable = lib.modules.mkForce false;
    };

    initrd.systemd.enable = true;
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.stateVersion = "24.11";
}
