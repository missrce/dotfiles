{
  flake.templates = {
    direnv = {
      path = ./direnv;
      description = "direnv Nix template";
    };
    rust = {
      path = ./rust;
      description = "A Rust template";
    };
  };
}
