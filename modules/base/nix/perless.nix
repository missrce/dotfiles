{config, ...}: {
  system = { 
    disableInstallerTools = true;
    switch = {
      enable = false;
      enableNg = true;
    };
  };

  environment.systemPackages = [
    config.system.build.nixos-rebuild
  ];

  # remove some useless utils that happen to be wrote in Perl

  programs.less.lessopen = null;
  programs.command-not-found.enable = false;
}
