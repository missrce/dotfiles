{
  config,
  pkgs,
  lib,
  ...
}: with config.lib.niri.actions; {
  # Workspaces
  "Mod+1".action = focus-workspace 1;
  "Mod+2".action = focus-workspace 2;
  "Mod+3".action = focus-workspace 3;
  "Mod+4".action = focus-workspace 4;
  "Mod+5".action = focus-workspace 5;
  "Mod+6".action = focus-workspace 6;
  "Mod+7".action = focus-workspace 7;
  "Mod+8".action = focus-workspace 8;
  "Mod+9".action = focus-workspace 9;
  "Mod+0".action = focus-workspace 10;

  "Alt+T".action = spawn "${lib.getExe pkgs.foot}";

  "XF86AudioRaiseVolume".action = spawn "${lib.getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
  "XF86AudioLowerVolume".action = spawn "${lib.getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
}
