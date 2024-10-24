{pkgs, ...}: {
  programs.hyfetch = {
    enable = true;

    package = pkgs.symlinkJoin {
      name = "hyfetch";
      paths = builtins.attrValues {inherit (pkgs) hyfetch fastfetch;};
    };

    settings = {
      preset = "transfeminine";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [];
        fore_back = null;
      };
      backend = "fastfetch";
      distro = null;
      pride_month_shown = [];
      pride_month_disable = true;
    };
  };
}
