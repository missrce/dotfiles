{
  osConfig,
  ...
}: {
  programs.fuzzel.enable = osConfig.missos.programs.terminal == "fuzzel";
}
