{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  # https://github.com/nix-community/home-manager/issues/4672
  systemd.user.services.expire-hm-profiles = {
    Unit.Description = "Clean up HM user profiles.";

    Service = {
      Type = "oneshot";
      ExecStart = getExe (pkgs.writeShellApplication {
        name = "expire-hm-profiles-start-script";
        text = ''
          ${getExe config.nix.package} profile wipe-history \
            --profile "${config.xdg.stateHome}/nix/profiles/home-manager" \
            --older-than '7d'
        '';
      });
    };
  };
  systemd.user.timers.expire-hm-profiles = {
    Unit.Description = "Clean up HM user profiles.";

    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };

    Install.WantedBy = ["timers.target"];
  };
}
