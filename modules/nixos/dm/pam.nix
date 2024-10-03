{
  security.pam.services = let
    common = {
      fprintAuth = true;
      enableGnomeKeyring = true;
      gnupg = {
        enable = true;
        noAutostart = true;
        storeOnly = true;
      };
    };
  in {
    login = common;
    sudo = {
      fprintAuth = true;
    };
  };
}
