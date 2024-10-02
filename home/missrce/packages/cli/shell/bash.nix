{
  config,
  ...
}:
{
  programs = {
    starship = {
      enable = true;
      
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
      enableIonIntegration = false;
      enableNushellIntegration = false;

      presets = [ "nerd-font-symbols" ];
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
        if [[ $(tty) == /dev/tty* ]]; then
          eval "$(${config.programs.starship.package} init bash)"
        fi
        echo -ne "\e[5 q"
      '';
    };
  };
}
