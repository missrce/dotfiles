{
  imports = [
    ./hw.nix
  ];

  missos = {
    environment = {
      desktop = "GNOME";
      loginManager = "gdm";
    };
    device = {
      type = "laptop";
      hasBluetooth = true;
      hasSound = true;
      hasTPM = true;
    };
    programs = {
      browser.chromium = true;
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
