{
  description = "missrce's dotfiles";

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./parts];};

  inputs = {
    # package suppliers
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # for other inputs to follow preventing multiple copies of systems when one is only needed.
    systems.url = "github:nix-systems/default-linux";

    # minimal flake wrapper
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # tree-wide formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # git commit hooks management
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nixpkgs-stable.follows = "";
        flake-compat.follows = "";
      };
    };

    # age-encrypted secrets for NixOS
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "home-manager";
        systems.follows = "systems";
      };
    };

    # userspace management
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # manage disk partition layouts
    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    # secure boot for nixos
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        pre-commit-hooks-nix.follows = "";
        flake-compat.follows = "";
      };
    };

    # niri WM
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    ags = {
      url = "github:Aylur/ags";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    # vscode extensions (they use flake-utils so as a reminder in future if any other input uses it make sure to follow it)
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-compat.follows = "";
      };
    };

    # catppuccin theming
    catppuccin = {
      type = "github";
      owner = "catppuccin";
      repo = "nix";
    };
  };
}
