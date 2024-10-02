{osConfig, ...}: {
  imports = [
    ./themes # Application themes
    ./services # Services with SystemD
    ./system # Home system configurations
    ./packages # Packages to install and configure
  ];

  home = {
    username = "missrce";
    homeDirectory = osConfig.users.users.missrce.home;
  };
}
