{
  lib,
  config,
  osConfig,
  ...
}: {
  home.file = lib.modules.mkIf osConfig.missos.system.interface.graphical {
    ".icons/default/index.theme".enable = false;
    ".icons/${config.home.pointerCursor.name}".enable = false;
  };
}
