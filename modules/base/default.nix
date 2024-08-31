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
  ];
}
