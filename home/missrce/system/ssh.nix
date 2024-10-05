{osConfig, ...}: let
  inherit (osConfig.age) secrets;
in {
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      # git clients
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = secrets.vcs-ssh.path;
      };

      "git.sr.ht" = {
        user = "git";
        hostname = "git.sr.ht";
        identityFile = secrets.vcs-ssh.path;
      };

      "gitlab.com" = {
        user = "git";
        hostname = "gitlab.com";
        identityFile = secrets.vcs-ssh.path;
      };
    };
  };
}
