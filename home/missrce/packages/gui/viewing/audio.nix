{pkgs, ...}: {
  home.packages = with pkgs; [gapless];

  xdg.mimeApps = let
    associations = {
      "audio/*" = [
        "com.github.neithern.g4music.desktop"
      ];
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
