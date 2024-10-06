{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe;
in {
  programs.fzf = {
    enable = true;

    defaultCommand = "${getExe pkgs.fd} --type=f --hidden --exclude=.git";
    defaultOptions = [
      "--height=50%"
      "--layout=reverse"
      "--info=inline"
    ];
  };
}
