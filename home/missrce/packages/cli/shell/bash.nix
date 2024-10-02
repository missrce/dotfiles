{
  config,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    historyFile = "/dev/null";
    historyFileSize = 0;
    profileExtra = ''
      . "${config.home.homeDirectory}/.config/environment.d/10-home-manager.conf"
    '';
    initExtra = ''
      if [[ $(tty) == /dev/pts/* ]]; then
        eval "$(${lib.getExe config.programs.starship.package} init bash)"
      fi
      echo -ne "\e[5 q"
    '';
  };
}
