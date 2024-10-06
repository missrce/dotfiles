{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkBefore;
  inherit (lib.strings) optionalString;
in {
  programs.bash = {
    enable = true;
    historyFile = "/dev/null";
    historyFileSize = 0;
    profileExtra = ''
      . "${config.home.homeDirectory}/.config/environment.d/10-home-manager.conf"
    '';
    initExtra = mkBefore ''
      ${optionalString config.programs.atuin.enable "export ATUIN_NOBIND=\"true\""}
      if [[ $(tty) == /dev/pts/* ]]; then
        eval "$(${lib.getExe config.programs.starship.package} init bash)"
        ${optionalString config.programs.atuin.enable "unset ATUIN_NOBIND"}
      fi
      echo -ne "\e[5 q"
      unset SSH_AUTH_SOCK
      unset __HM_SESS_VARS_SOURCED
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
      . "${config.home.homeDirectory}/.config/environment.d/10-home-manager.conf"
    '';
  };
}
