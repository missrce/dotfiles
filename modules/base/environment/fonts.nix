{pkgs, ...}: {
  fonts = {
    packages = [
      pkgs.inter
      pkgs.noto-fonts-cjk-sans
      pkgs.source-sans-pro
      pkgs.commit-mono
      (pkgs.nerdfonts.override {
        fonts = ["Commit Mono"];
      })
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Inter Variable" "Inter Variable Regular" "Inter" "Inter Regular" "Cantarell" "DejaVu Sans"];
        monospace = ["CommitMono Nerd Font" "Commit Mono" "DejaVu Sans Mono"];
      };
    };
  };
}
