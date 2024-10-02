{osConfig, ...}: {
  imports = [
    ./themes # Application themes
    ./system # Home system configurations
  ];

  home = {
    username = "missrce";
    homeDirectory = osConfig.users.users.missrce.home;
  };
}
