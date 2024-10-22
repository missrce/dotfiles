{
  programs.mpv.enable = true;

  xdg.mimeApps = let
    associations = {
      "video/*" = [
        "mpv.desktop"
      ];
    };
  in {
    enable = true;
    associations.added = associations;
    defaultApplications = associations;
  };
}
