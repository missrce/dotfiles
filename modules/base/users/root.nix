{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  users.users.root = {
    hashedPassword = mkForce "!"; # Prevent logins

    openssh.authorizedKeys.keys = mkForce []; # Stop SSH for the root user as it is unsafe
  };
}
