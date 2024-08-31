{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.lists) optionals;
  inherit (lib.types) enum listOf str;
in {
  config.warnings = optionals (config.missos.system.users == []) [
    ''
      You have not added any users to be supported by your system. You may end up with an unbootable system!

      Consider setting {option}`config.missos.system.users` in your configuration
    ''
  ];

  options.missos.system = {
    mainUser = mkOption {
      type = enum config.missos.system.users;
      description = "The username of the main user for your system";
      default = builtins.elemAt config.missos.system.users 0;
    };

    users = mkOption {
      type = listOf str;
      default = ["missrce"];
      description = ''
        A list of users that you wish to declare as your non-system users. The first username
        in the list will be treated as your main user unless {option}`missos.system.mainUser` is set.
      '';
    };
  };
}
