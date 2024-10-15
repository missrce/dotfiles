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

    # Workspace window movement
    "Mod+Shift+1".action = move-window-to-workspace 1;
    "Mod+Shift+2".action = move-window-to-workspace 2;
    "Mod+Shift+3".action = move-window-to-workspace 3;
    "Mod+Shift+4".action = move-window-to-workspace 4;
    "Mod+Shift+5".action = move-window-to-workspace 5;
    "Mod+Shift+6".action = move-window-to-workspace 6;
    "Mod+Shift+7".action = move-window-to-workspace 7;
    "Mod+Shift+8".action = move-window-to-workspace 8;
    "Mod+Shift+9".action = move-window-to-workspace 9;
    "Mod+Shift+0".action = move-window-to-workspace 10;

    # Workspace column movement
    "Mod+Ctrl+1".action = move-column-to-workspace 1;
    "Mod+Ctrl+2".action = move-column-to-workspace 2;
    "Mod+Ctrl+3".action = move-column-to-workspace 3;
    "Mod+Ctrl+4".action = move-column-to-workspace 4;
    "Mod+Ctrl+5".action = move-column-to-workspace 5;
    "Mod+Ctrl+6".action = move-column-to-workspace 6;
    "Mod+Ctrl+7".action = move-column-to-workspace 7;
    "Mod+Ctrl+8".action = move-column-to-workspace 8;
    "Mod+Ctrl+9".action = move-column-to-workspace 9;
    "Mod+Ctrl+0".action = move-column-to-workspace 10;

    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-up;
    "Mod+Down".action = focus-window-down;

    "Mod+Shift+Left".action = move-column-left;
    "Mod+Shift+Right".action = move-column-right;
    "Mod+Shift+Up".action = move-window-up;
    "Mod+Shift+Down".action = move-window-down;

    # Power controls
    "Mod+Shift+E".action = quit;
    "Mod+Shift+P".action = power-off-monitors;

    # Window controls
    "Mod+W".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;

    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";

    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    # Mouse
    "Mod+WheelScrollDown".action = focus-workspace-down;
    "Mod+WheelScrollUp".action = focus-workspace-up;
    "Mod+Shift+WheelScrollDown".action = move-column-to-workspace-down;
    "Mod+Shift+WheelScrollUp".action = move-column-to-workspace-up;

    # Screenshot
    "Print".action = screenshot-screen;
    "Mod+Print".action = screenshot;
    "Mod+Shift+Print".action = screenshot-window;

    # Applications
    "Alt+T".action = spawn "${getExe config.programs.${osConfig.missos.programs.terminal}.package}";
    "Alt+Q".action = spawn "${getExe config.programs.${osConfig.missos.programs.browser}.package}";
    "Mod+D".action = spawn "${getExe config.programs.${osConfig.missos.programs.launcher}.package}";

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
