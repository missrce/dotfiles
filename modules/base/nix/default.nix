{
  imports = [
    ./perless.nix # perless 50/50 removes some Perl related junk
    ./switch.nix # better switch
    ./nix.nix # nix the package manager's settings
    ./nixpkgs.nix # nixpkgs configuration
    ./substituters.nix # nixpkgs substituters
    ./system.nix # system settings that nix needs
  ];
}
