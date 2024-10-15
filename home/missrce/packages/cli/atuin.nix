{config, lib, ...}: let
  inherit (lib.meta) getExe;
in {
  programs.atuin = {
    enable = true;

    flags = ["--disable-ctrl-r"];

    settings = {
      dialect = "uk";
      style = "compact";
      show_preview = true;
      secrets_filter = true;
      update_check = false;
      common_prefix = [
        "sudo"
      ];
      daemon.systemd_socket = true;
    };
  };
  home.sessionVariables = {
    ATUIN_DAEMON__SOCKET_PATH = "$XDG_RUNTIME_DIR/atuin.sock";
  };
  systemd.user.services.atuin-daemon = {
    Unit = {
      Description = "atuin daemon";
      Requires = ["atuin-daemon.socket"];
    };
    Install = {
      Also = ["atuin-daemon.socket"];
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${getExe config.programs.atuin.package} daemon";
      Environment = [
        "ATUIN_LOG=info"
        "ATUIN_DAEMON__SOCKET_PATH=%t/atuin.sock"
      ];
      Restart = "on-failure";
      RestartSteps = 3;
      RestartMaxDelaySec = 6;
    };
  };
  systemd.user.sockets.atuin-daemon = {
    Unit = {
      Description = "atuin daemon socket";
    };
    Install = {
      WantedBy = ["sockets.target"];
    };
    Socket = {
      ListenStream = "%t/atuin.sock";
      SocketMode = "0600";
      RemoveOnStop = true;
    };
  };
}
