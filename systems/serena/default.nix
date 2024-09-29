{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      desktop = "Hyprland";
      loginManager = "autologin";
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
