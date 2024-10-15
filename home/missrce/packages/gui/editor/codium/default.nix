{osConfig, inputs, pkgs, lib, ...}: {
  programs.vscode = {
    enable = osConfig.missos.system.interface.graphical;
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    # https://github.com/nix-community/home-manager/issues/4394#issuecomment-1712909231
    mutableExtensionsDir = false;
    userSettings = import ./settings.nix { inherit osConfig pkgs lib; };
    extensions = pkgs.callPackage ./extensions.nix {
      extensions = (inputs.vscode-extensions.extensions.${osConfig.nixpkgs.system}.forVSCodeVersion pkgs.vscodium.version).vscode-marketplace;
    };
  };
}
