let
  inherit (import ../ssh.nix) users agenix;

  defineAccess = list: list ++ [users.missrce];

  all = defineAccess (builtins.attrValues agenix);
  workstations = defineAccess [agenix.serena agenix.vega];
in {
  "keys/git/ssh.age".publicKeys = all;
  "keys/git/gpg.age".publicKeys = all;

  "keys/messages/gpg.age".publicKeys = workstations;
}
