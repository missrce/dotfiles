{pkgs, ...}: {
  # No more (e)xterm(inator)

  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}
