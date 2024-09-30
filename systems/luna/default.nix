{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      desktop = "Hyprland";
      loginManager = "sddm";
    };
    device = {
      type = "laptop";
      hasBluetooth = true;
      hasSound = true;
      hasTPM = true;
    };
    system = {
      interface.graphical = true;
      yubikeySupport = true;
      security = {
        auditd = {
          enable = true;
          autoPrune.enable = true;
        };
      };
    };
  };
}
