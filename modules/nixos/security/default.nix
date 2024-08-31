# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix
# https://github.com/fort-nix/nix-bitcoin/blob/master/modules/presets/hardened-extended.nix
{modulesPath, ...}: {
  imports = [
    "${modulesPath}/profiles/hardened.nix"
    ./kernel.nix
    ./sudo.nix
    ./apparmor.nix
    ./polkit.nix
  ];
}
