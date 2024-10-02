let
  inherit (builtins) elem filter hasAttr;

  ifGroupsExist = config: groups: filter (group: hasAttr group config.users.groups) groups;

  isAcceptedDevice = conf: list: elem conf.missos.device.type list;
in {
  inherit isAcceptedDevice ifGroupsExist;
}
