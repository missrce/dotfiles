{config, ...}: let
  inherit (config.missos) system;
in {
  services.getty.autologinUser = system.mainUser;
}
