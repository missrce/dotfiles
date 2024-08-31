let
  inherit (builtins) filter hasAttr;

  ifGroupsExist = config: groups: filter (group: hasAttr group config.users.groups) groups;
in {
  inherit ifGroupsExist;
}
