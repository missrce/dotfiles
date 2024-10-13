{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      desktop = "niri";
      loginManager = "getty";
    };
    device = {
      type = "desktop";
      hasBluetooth = true;
      hasSound = true;
      hasTPM = true;
    };
    system = {
      mainUserHashedPassword = "$y$j9T$tIq/hBimd7jvSr2bL/Lm0/$W0tjpjhc2dGy/F8mf4ASBqrGjO9YXUh9cEvAPNA.hvC";

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
