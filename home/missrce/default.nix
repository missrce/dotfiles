{osConfig, ...}: {
  imports = [
    ./themes # Application themes
    ./system # Home system configurations
    ./packages # Packages to install and configure
  ];

  home = {
    username = "missrce";
    homeDirectory = osConfig.users.users.missrce.home;
  };
}
