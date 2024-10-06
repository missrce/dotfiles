{
  programs.eza = {
    enable = true;
    icons = true;

    extraOptions = [
      "--group"
      "--group-directories-first"
      "--header"
      "--no-permissions"
      "--octal-permissions"
    ];
  };

  home.shellAliases = {
    ls = "eza";
  };
}
