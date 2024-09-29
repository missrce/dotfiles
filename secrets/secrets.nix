let
  inherit (import ../ssh.nix) users agenix;

  defineAccess = list: { publicKeys = list ++ builtins.attrValues users; };

  all = defineAccess (builtins.attrValues agenix);
  workstations = defineAccess [agenix.serena agenix.luna];
in {
  "keys/git/ssh.age" = all;
  "keys/git/gpg.age" = all;

  "keys/messages/gpg.age" = workstations;
}
