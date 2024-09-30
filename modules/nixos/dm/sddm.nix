{
  pkgs,
  config,
  ...
}: let
  inherit (config.missos) environment;
in {
  services.displayManager.sddm = {
    enable = environment.loginManager == "sddm";
    package = pkgs.kdePackages.sddm; # allow qt6 themes to work
    wayland.enable = true; # run under wayland rather than X11
    # settings.General.InputMethod = "";
  };
}
