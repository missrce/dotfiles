{pkgs, ...}: {
  systemd.services.systemd-udev-settle.enable = false;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
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
    plymouth = {
      enable = true;
      theme = "spinner";
    };
  };
}
