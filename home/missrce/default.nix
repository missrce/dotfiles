{osConfig, ...}: {
  imports = [
    ./themes # Application themes
  ];

  home = {
    username = "missrce";
    homeDirectory = osConfig.users.users.missrce.home;
  };
}
