{osConfig, ...}: {
  programs.fuzzel.enable = osConfig.missos.programs.launcher == "fuzzel";
}
