{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (lib.secrets) mkSecret;

  inherit (config.missos.system) mainUser;

  homeDir = "/home/${mainUser}";
  sshDir = "${homeDir}/.ssh";

  userGroup = "users";
in {
  imports = [inputs.agenix.nixosModules.default];

  age = {
    identityPaths = [
      "/etc/ssh/agenix/id_ed25519"
      "${sshDir}/id_ed25519"
    ];

    secrets = {
      # Git secrets

      vcs-ssh = mkSecret {
        file = "keys/vcs/ssh";
        owner = mainUser;
        group = userGroup;
      };

      vcs-gpg = mkSecret {
        file = "keys/vcs/gpg";
        owner = mainUser;
        group = userGroup;
      };
    };
  };
}
