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

      git-ssh = mkSecret {
        file = "keys/git/ssh.age";
        owner = mainUser;
        group = userGroup;
      };

      git-gpg = mkSecret {
        file = "keys/git/gpg.age";
        owner = mainUser;
        group = userGroup;
      };
    };
  };
}
