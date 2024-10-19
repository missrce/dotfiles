{config, ...}: {
  home.sessionVariables = {
    EDITOR = "micro";
    VISUAL = "codium";
    SUDO_EDITOR = "micro";

    FLAKE = "${config.xdg.userDirs.extraConfig.XDG_DEV_DIR}/dotfiles";
    SYSTEMD_PAGERSECURE = "true";
    PAGER = "less -FR";
  };
}
