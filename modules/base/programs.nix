{pkgs, ...}: {
  # programs = {
  #   starship = {
  #     enable = true;
  #     presets = [
  #       "nerd-font-symbols"
  #     ];
  #   };

  # bash = {
  #   enable = true;
  # historyFile = "/dev/null";
  # historyFileSize = 0;
  # initExtra = ''
  #   echo -ne "\e[5 q"
  # '';
  # };
  # };
  environment.systemPackages = with pkgs; [
    micro
  ];
}
