{
  description = "missrce's dotfiles";

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./parts];};

  inputs = {
    # Package suppliers

    nixpkgs-master = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    # For other inputs to follow preventing multiple copies of systems when one is only needed.

    systems = {
      type = "github";
      owner = "nix-systems";
      repo = "default";
    };

    # For other inputs to follow preventing multiple copies of flake-utils when one is only needed.

    flake-utils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      inputs.systems.follows = "systems";
    };

    # Minimal flake wrapper

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Tree-wide formatter

    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Git commit hooks management

    git-hooks = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nixpkgs-stable.follows = "";
        flake-compat.follows = "";
      };
    };

    # age-encrypted secrets for NixOS

    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "";
        systems.follows = "systems";
      };
    };

    # Userspace management

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure Boot for NixOS

    lanzaboote = {
      type = "github";
      owner = "nix-community";
      repo = "lanzaboote";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks-nix.follows = "";
        flake-compat.follows = "";
      };
    };

    # Impermanence

    impermanence.url = "github:nix-community/impermanence";

    # Hyprland flake

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;

      inputs.systems.follows = "systems";
    };

    # Catppuccin Theming
    catppuccin = {
      type = "github";
      owner = "catppuccin";
      repo = "nix";
    };
  };
}
