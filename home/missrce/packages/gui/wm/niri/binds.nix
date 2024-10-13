{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe getExe';
in
  with config.lib.niri.actions; {
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

    # Window controls
    "Mod+W".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";

    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    # Screenshot
    "Print".action = screenshot-screen;
    "Mod+Print".action = screenshot;
    "Mod+Shift+Print".action = screenshot-window;

    # Applications
    "Alt+T".action = spawn "${lib.getExe config.programs.${osConfig.missos.programs.terminal}.package}";

    # Volume keys

    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action = spawn "${getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action = spawn "${getExe' pkgs.wireplumber "wpctl"}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action = spawn "${getExe' pkgs.wireplumber "wpctl"}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action = spawn "${getExe' pkgs.wireplumber "wpctl"}" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
    };

    # Player keys
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action = spawn "${getExe pkgs.playerctl}" "play-pause";
    };
    "XF86AudioPause" = {
      allow-when-locked = true;
      action = spawn "${getExe pkgs.playerctl}" "play-pause";
    };
    "XF86AudioStop" = {
      allow-when-locked = true;
      action = spawn "${getExe pkgs.playerctl}" "stop";
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action = spawn "${getExe pkgs.playerctl}" "next";
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action = spawn "${getExe pkgs.playerctl}" "previous";
    };
  }
