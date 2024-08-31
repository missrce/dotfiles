{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    allowBroken = false;
    permittedInsecurePackages = [];
    allowUnsupportedSystem = true;
    allowAliases = false;
  };
}
