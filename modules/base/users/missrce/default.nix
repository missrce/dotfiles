{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.validators) ifGroupsExist;
in {
  users.users.missrce = {
    isNormalUser = true;
    description = "Integra";
    shell = pkgs.bash;
    hashedPassword = config.missos.system.mainUserHashedPassword;
    openssh.authorizedKeys.keys = config.boot.initrd.network.ssh.authorizedKeys;
    extraGroups =
      ["wheel" "nix"]
      ++ ifGroupsExist config [
        "network"
        "networkmanager"
        "systemd-journal"
        "audio"
        "pipewire"
        "video"
        "input"
        "plugdev"
        "lp"
        "tss"
        "power"
        "wireshark"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
        "cloudflared"
        "qemu-libvirtd"
        "disk"
        "postgres"
      ];
  };
}
