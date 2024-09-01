{pkgs, ...}: {
  # Creates /var/log/syslog which is required for AppArmor
  services = {
    syslogd.enable = true;
    syslogd.extraConfig = ''
      *.* -/var/log/syslog
    '';
  };

  services.dbus.apparmor = "enabled";

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
        enable = false;
        profile = ''
          profile default_deny /** { }
        '';
      };
    };
  };
}
