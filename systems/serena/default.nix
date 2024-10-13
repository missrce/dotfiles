{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      desktop = "niri";
      loginManager = "sddm";
    };
    device = {
      type = "desktop";
      hasBluetooth = true;
      hasSound = true;
      hasTPM = true;
    };
    programs = {
      browser.chromium = true;
      terminal = "foot";
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
