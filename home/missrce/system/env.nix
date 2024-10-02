{
  systemd.user.sessionVariables = {
    EDITOR = "micro";
    VISUAL = "codium";
    SUDO_EDITOR = "micro";

    FLAKE = "/etc/nixos";
    SYSTEMD_PAGERSECURE = "true";
    PAGER = "less -FR";
  };
}
