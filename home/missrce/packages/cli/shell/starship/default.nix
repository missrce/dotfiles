{
  programs.starship = {
    enable = true;

    catppuccin.enable = true;

    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;

    settings =
      builtins.fromTOML (builtins.readFile ./nerd-font-symbols.toml)
      // {
        battery.disabled = true;
      };
  };
}
