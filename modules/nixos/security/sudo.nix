{
  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = false;
    extraRules = [
      {
        commands =
          builtins.map (command: {
            command = "/run/current-system/sw/bin/${command}";
            options = ["NOPASSWD"];
          })
          ["poweroff" "reboot" "nixos-rebuild" "nix-env" "bandwhich" "mic-light-on" "mic-light-off" "systemctl"];
        groups = ["wheel"];
      }
    ];
  };
}
