{
  osConfig,
  ...
}: {
  programs.foot.enable = osConfig.missos.programs.terminal == "foot";
}
