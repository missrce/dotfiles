{pkgs, ...}: {
  services.dbus.apparmor = "disabled";

  apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    packages = [pkgs.apparmor-profiles];
  };
}
