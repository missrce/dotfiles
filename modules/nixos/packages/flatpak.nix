{config, ...}: {
  services.flatpak.enable = config.missos.system.interface.graphical;
}
