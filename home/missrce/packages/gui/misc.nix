{pkgs, ...}: {
  home.packages = with pkgs; [
    # Offline password manager
    keepassxc
  ];
}