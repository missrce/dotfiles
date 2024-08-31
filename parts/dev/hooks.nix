{ lib, inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    { pkgs, config, ... }:
    let
      # don't format these
      excludes = [
        "flake.lock"
        "r'.+\.age$'"
        "r'.+\.patch$'"
      ];

      mkHook = name: {
        inherit excludes;
        enable = true;
        description = "pre commit hook for ${name}";
        fail_fast = true;
        verbose = true;
      };

      mkHook' = name: prev: (mkHook name) // prev;
    in
    {
      pre-commit = {
        check.enable = true;

        settings = {
          inherit excludes;

          hooks = {
            statix = mkHook "statix"; # Nix linting and suggestions
            deadnix = mkHook "deadnix"; # detecting unused Nix code

            treefmt = mkHook' "treefmt" { package = config.treefmt.build.wrapper; }; # ensure the codebase is formatted

            # ensure the editorconfig is followed
            editorconfig-checker = mkHook' "editorconfig" {
              enable = lib.mkForce false;
              always_run = true;
            };
          };
        };
      };
    };
}
