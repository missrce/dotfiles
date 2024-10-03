{
  config,
  inputs,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.home-manager.impermanence];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [
      ".gnupg"
      ".ssh"
      ".local/share/keyrings"
    ];
    allowOther = true;
  };
}
