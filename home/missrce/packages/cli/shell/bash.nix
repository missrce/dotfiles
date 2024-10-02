{
  config,
  lib,
  ...
}: {
  programs = {
    starship = {
      enable = true;

      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
      enableIonIntegration = false;
      enableNushellIntegration = false;

      settings = {
        battery.disabled = true;
      };
    };
    bash = {
      enable = true;
      historyFile = "/dev/null";
      historyFileSize = 0;
      profileExtra = ''

      '';
      initExtra = ''
        if [[ $(tty) == /dev/pts/* ]]; then
          eval "$(${lib.getExe config.programs.starship.package} init bash)"
        fi
        echo -ne "\e[5 q"
      '';
    };
  };
}
