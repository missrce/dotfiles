{
  imports = [
    # Import user configurations
    ./users
    # Import Nix configuration
    ./nix
    # Import the environment config
    ./environment
    # Add options
    ./options

    ./programs.nix # basic programs required for ANY install
    ./secrets.nix # DO NOT SHARE :3c
  ];
}
