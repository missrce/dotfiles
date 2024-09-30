{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.catppuccin.nixosModules.catppuccin];

  catppuccin = {
    enable = true;
    flavor = lib.modules.mkDefault "macchiato";
    accent = lib.modules.mkDefault "pink";
  };
}
