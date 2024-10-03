{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
in {
  systemd = mkIf config.missos.system.interface.graphical {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "GNome PolicyKit(ty) :3 Agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };

      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  };

  # have polkit log all actions
  security.polkit = {
    enable = true;
    debug = mkDefault true;

    # the below configuration depends on security.polkit.debug being set to true
    # so we have it written only if debugging is enabled
    extraConfig = mkIf config.security.polkit.debug ''
      /* Log authorization checks. */
      polkit.addRule(function(action, subject) {
        polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
      });
    '';
  };
}
