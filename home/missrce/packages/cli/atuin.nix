{
  programs.atuin = {
    enable = true;
    
    flags = ["--disable-ctrl-r"];

    settings = {
      dialect = "uk";
      style = "compact";
      show_preview = true;
      secrets_filter = true;
      update_check = false;
      common_prefix = [
        "sudo"
      ];
    };
  };
}
