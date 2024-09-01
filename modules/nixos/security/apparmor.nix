{
  config,
  pkgs,
  ...
}: {
  # Creates /var/log/syslog which is required for AppArmor
  services = {
    syslogd.enable = true;
    syslogd.extraConfig = ''
      *.* -/var/log/syslog
    '';
  };

  services.dbus.apparmor = "enabled";

  environment.systemPackages = with pkgs; [
    apparmor-pam
    apparmor-utils
    apparmor-parser
    apparmor-profiles
    apparmor-bin-utils
    apparmor-kernel-patches
    libapparmor
  ];

  # apparmor configuration
  security.apparmor = {
    enable = true;

    # whether to enable the AppArmor cache
    # in /var/cache/apparmor
    enableCache = true;

    # whether to kill processes which have an AppArmor profile enabled
    # but are not confined (AppArmor can only confine new processes)
    killUnconfinedConfinables = true;

    # packages to be added to AppArmor’s include path
    packages = [pkgs.apparmor-profiles];

    # apparmor policies
    policies = {
      "default_deny" = {
        enforce = false;
        enable = true;
        profile = ''
          profile default_deny /** { }
        '';
      };

      "sudo" = {
        enforce = false;
        enable = false;
        profile = ''
          ${pkgs.sudo}/bin/sudo {
            file /** rwlkUx,
          }
        '';
      };

      "ping" = let
        inherit (pkgs) ping;
      in {
        enforce = true;
        enable = true;
        profile = ''
          #include <abstractions/base>
          #include <abstractions/consoles>
          #include <abstractions/nameservice>

          capability net_raw,
          capability setuid,
          network inet raw,

          ${ping} mixr,
          /etc/modules.conf r,
        '';
      };

      "nix" = {
        enforce = false;
        enable = false;
        profile = ''
          ${config.nix.package}/bin/nix {
            unconfined,
          }
        '';
      };
    };
  };
}
