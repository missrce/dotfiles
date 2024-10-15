{
  osConfig,
  lib,
  ...
}: {
  services.kdeconnect = lib.modules.mkIf osConfig.missos.system.interface.graphical {
    enable = true;
    indicator = true;
  };
}
