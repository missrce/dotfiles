{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  environment.memoryAllocator.provider = mkForce "libc";
  environment.variables.SCUDO_OPTIONS = mkForce "";
}
