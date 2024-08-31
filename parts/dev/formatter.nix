{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    formatter = config.treefmt.build.wrapper;

    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        # Nix formatting
        nixfmt = {
          enable = true;
          package = pkgs.alejandra;
        };
        # Enable sanity checks for shell scripts
        shellcheck.enable = true;
        # Shell script formatting
        shfmt = {
          enable = true;
          indent_size = 2;
        };
      };
    };
  };
}
