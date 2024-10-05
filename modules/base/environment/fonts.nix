{
  lib,
  pkgs,
  ...
}: {
  console = {
    enable = lib.modules.mkDefault true;
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-d16b.psf.gz";
  };
  fonts = {
    packages = [
      pkgs.inter
      pkgs.noto-fonts-cjk-sans
      pkgs.source-sans-pro
      pkgs.commit-mono
      (pkgs.nerdfonts.override {
        fonts = ["CommitMono"];
      })
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Inter Variable" "Inter Variable Regular" "Inter" "Inter Regular" "Cantarell" "DejaVu Sans"];
        monospace = ["CommitMono Nerd Font" "CommitMono" "DejaVu Sans Mono"];
      };
    };
  };
}
