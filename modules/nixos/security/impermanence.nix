{inputs, lib, ...}: let
  inherit (lib.lists) forEach;
in {
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };
  programs.fuse.userAllowOther = true;
  environment.persistence."/persist" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = forEach ["nixos" "NetworkManager" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
    ++ forEach [ "bluetooth" "nixos" "pipewire" "libvirt" "fail2ban" ] (x: "/var/lib/${x}")
    ++ [
      "/tmp"
      "/var/log"
      "/var/db/sudo"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  # stolen from sioodmy's to fix NetworkManager
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
