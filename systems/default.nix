{inputs, ...}: let
  inherit (inputs) self;
  inherit (self) lib;

  inherit (builtins) filter;

  inherit (lib.builders) mkSystems;
  inherit (lib.attrsets) listToAttrs;

  systems = [
    {
      host = "solstice";
      target = "iso";
      modules = [];
    }
  ];
in {
  flake = {
    nixosConfigurations = mkSystems (filter (sys: sys.target == "nixos") systems);

    vms = listToAttrs (
      map (system: {
        name = system.host;
        value = self.nixosConfigurations.${system.host}.config.system.build.vm;
      })
      systems
    );

    images = let
      isos = filter (x: x.target == "iso") systems;
    in
      listToAttrs (
        map (iso: {
          name = iso.host;
          value = inputs.self.nixosConfigurations.${iso.host}.config.system.build.isoImage;
        })
        isos
      );
  };
}
