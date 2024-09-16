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
    description = "Buttercup";
    shell = pkgs.bash;
    hashedPassword = "$y$j9T$tIq/hBimd7jvSr2bL/Lm0/$W0tjpjhc2dGy/F8mf4ASBqrGjO9YXUh9cEvAPNA.hvC";
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
