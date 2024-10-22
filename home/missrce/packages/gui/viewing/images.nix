{pkgs, ...}: {
  home.packages = with pkgs; [ loupe ];

  xdg.mimeApps = let
    associations = {
      "image/*" = [
        "org.gnome.Loupe.desktop"
      ];
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
