{
  security.sudo = {
    enable = true;
    execWheelOnly = true;

    extraConfig = ''
      Defaults lecture = never
      Defaults pwfeedback
      Defaults timestamp_timeout = 300
    '';
  };
}
