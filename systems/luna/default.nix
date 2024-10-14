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
      type = "laptop";
      hasBluetooth = true;
      hasSound = true;
      hasTPM = true;
    };
    programs = {
      browser = "chromium";
      launcher = "fuzzel";
      terminal = "foot";
    };
    system = {
      mainUserHashedPassword = "$y$j9T$MARUL6K4RRYl1afeV0IkX1$x8tx0t29j1iNPG.cEdxMZQEWq13n4hdZ5W6EmgfcwGD";

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
