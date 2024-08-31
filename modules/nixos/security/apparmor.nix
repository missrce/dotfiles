{pkgs, ...}: {
  services.dbus.apparmor = "disabled";

  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    packages = [pkgs.apparmor-profiles];
  };
}
