{
  imports = [
    ./hw.nix
  ];

  missos = {
    device = {
      type = "desktop";
      hasBluetooth = true;
      hasSound = true;
    };
    system = {
      interface.graphical = true;
      yubikeySupport = true;
    };
  };
}
