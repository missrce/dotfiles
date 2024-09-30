{
  config,
  lib,
  ...
}: let
  inherit (config.missos) system environment;
  inherit (lib.modules) mkIf;
in {
  services.getty.autologinUser = mkIf environment.loginManager == "sddm" system.mainUser;
}
