{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  security = {
    unprivilegedUsernsClone = mkForce true;
    allowUserNamespaces = mkForce true;
    allowSimultaneousMultithreading = true; # "Disabling SMT means that only physical CPU cores will be usable at runtime, potentially at significant performance cost."
  };
}
