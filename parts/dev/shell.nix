{
  perSystem = {
    pkgs,
    self',
    config,
    inputs',
    ...
  }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        name = "dotfiles";
        meta.description = "Development shell for this configuration";

        shellHook = config.pre-commit.installationScript;

        packages = [
          pkgs.git # Nix flakes require git
          self'.formatter # nix fmt
          pkgs.nix-output-monitor # get clean diff between generations
          inputs'.agenix.packages.agenix # secrets
        ];

        inputsFrom = [config.treefmt.build.devShell];
      };
    };
  };
}
