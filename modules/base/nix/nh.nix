{config, ...}: {
  programs.nh = {
    enable = true;

    clean = {
      enable = !config.nix.gc.automatic;
      extraArgs = "--keep-since 7d";
      dates = "weekly";
    };
  };

  system.disableInstallerTools = config.programs.nh.enable;
}
