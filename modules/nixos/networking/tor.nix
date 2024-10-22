{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.missos.system.security.tor;
in
{
  options.missos.system.security.tor.enable = mkEnableOption "Tor daemon";

  config.services.tor = mkIf cfg.enable {
    enable = true;
    client.enable = true;
    client.dns.enable = true;
    torsocks.enable = true;
  };
}
