{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      loginManager = "sddm";
    };
    device = {
      type = "desktop";
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
