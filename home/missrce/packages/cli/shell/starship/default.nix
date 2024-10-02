{
  programs.starship = {
    enable = true;

    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;

    settings = builtins.fromTOML (builtins.readFile ./jetpack.toml) // {
      battery.disabled = true;
    };
  };
}
