{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (lib.attrsets) filterAttrs attrValues mapAttrs;

  flakeInputs = filterAttrs (name: value: (value ? outputs) && (name != "self")) inputs;
in {
  nix = {
    package = pkgs.nixVersions.latest;

    registry = mapAttrs (_: v: {flake = v;}) flakeInputs;

    nixPath = attrValues (mapAttrs (k: v: "${k}=${v.outPath}") flakeInputs);

    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;

      allowed-users = [
        "@wheel" # allow sudo users to mark the following values as trusted
        "root"
        config.missos.system.mainUser
      ];
      trusted-users = [
        "@wheel" # allow sudo users to manage the nix store
        "root"
        config.missos.system.mainUser
      ];
      use-registries = true;
      flake-registry = pkgs.writers.writeJSON "flakes-empty.json" {
        flakes = [];
        version = 2;
      };
      max-jobs = "auto";
      sandbox = true;
      system-features = [
        "nixos-test"
        "kvm"
        "recursive-nix"
        "big-parallel"
      ];
      keep-going = true;
      log-lines = 30;
      extra-experimental-features = [
        # enables flakes, needed for this config
        "flakes"

        # enables the nix3 commands, a requirement for flakes
        "nix-command"

        # allow nix to build and use content addressable derivations, these are nice beaccase
        # they prevent rebuilds when changes to the derivation do not result in changes to the derivation's output
        "ca-derivations"

        # Allows Nix to automatically pick UIDs for builds, rather than creating nixbld* user accounts
        # which is BEYOND annoying, which makes this a really nice feature to have
        "auto-allocate-uids"

        # allows Nix to execute builds inside cgroups
        # remember you must also enable use-cgroups in the nix.conf or settings
        "cgroups"
      ];
      warn-dirty = false;
      http-connections = 50;
      accept-flake-config = false;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      # use xdg base directories for all the nix things
      use-xdg-base-directories = true;
    };
  };
}
