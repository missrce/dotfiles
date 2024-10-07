{pkgs, ...}: let
  fileManager = pkgs.dolphin; # swim through tem files

  associations = {
    "inode/directory" = [
      "org.kde.dolphin.desktop"
    ];
  };
in {
  home.packages = [
    fileManager
  ];

  xdg.mimeApps = {
    assocations.added = associations;
    defaultApplications = associations;
  };
}
