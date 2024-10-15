{osConfig, inputs, pkgs, lib, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    # https://github.com/nix-community/home-manager/issues/4394#issuecomment-1712909231
    mutableExtensionsDir = false;
    userSettings = import ./settings.nix { inherit lib pkgs; };
    extensions = pkgs.callPackage ./extensions.nix {
      extensions = (inputs.vscode-extensions.extensions.${osConfig.nixpkgs.system}.forVSCodeVersion pkgs.vscodium.version).vscode-marketplace;
    };
  };
}
