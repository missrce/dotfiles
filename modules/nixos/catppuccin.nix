{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.catppuccin.nixosModules.catppuccin];

  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "macchiato";
  };
}
