{
  programs = {
    starship.enable = true;

    bash = {
      enable = true;
      historyFile = "/dev/null";
      historyFileSize = 0;
      initExtra = ''
        echo -ne "\e[5 q"
      '';
    };
  };
}
