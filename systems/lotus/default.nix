{
  imports = [
    ./hw.nix
  ];

  missos = {
    device = {
      type = "server";
      hasBluetooth = false;
      hasSound = false;
      hasTPM = true;
    };
    system = {
      mainUserHashedPassword = "$y$j9T$g1yCzDtif3jVZ2fwqupAS1$2tYtS/GQT.BqUjFU555I.gGHCj9eNd.gpChMWh/zox1";
      security = {
        auditd = {
          enable = true;
          autoPrune.enable = true;
        };
      };
    };
  };
}
