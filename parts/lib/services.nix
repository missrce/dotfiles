{lib}: let
  inherit (lib.attrsets) recursiveUpdate;

  mkGraphicalService = recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  inherit mkGraphicalService;
}
