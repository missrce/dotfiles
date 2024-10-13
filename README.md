# dotfiles

My system configurations built for privacy, security and stability.

## Options reference

All entries are case-insensitive, well apart from booleans but come on that's common sense.

```nix
{
  system = {
    interface.graphical = boolean;
    yubikeySupport = boolean;
    mainUser = "";
    users = []; # array of usernames that will be configured for the system
  };
  device = {
    type = "";
    hasTPM = boolean;
    hasBluetooth = boolean;
    hasSound = boolean;
  };
  programs = {
    browser = "";
    launcher = "";
    terminal = "";
    games = {
      steam = boolean;
      minecraft = boolean;
    };
  };
  environment = {
    desktop = "";
    loginManager = "";
  };
}
```
