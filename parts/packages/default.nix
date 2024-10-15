# I would highly advise you do not use my flake as an input and instead you vendor this
# if you want to use this code, you may want to add my cachix cache to your flake
# you may want to not have to build this for yourself however
{
  perSystem = {pkgs, ...}: {
    packages.nvidia-offload = import ./nvidia-offload.nix {inherit pkgs;};
  };
}
