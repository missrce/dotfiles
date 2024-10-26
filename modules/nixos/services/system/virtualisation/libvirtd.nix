{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkAfter mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.missos.system;
in {
  options.missos.system.virtualisation.libvirtd.enable = mkEnableOption "Enable libvirtd";
  config = mkIf cfg.virtualisation.libvirtd.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
              msVarsTemplate = true;
            })
            .fd
          ];
        };
      };
    };

    systemd.services.libvirtd-config.script = let
      ovmfpackage = pkgs.buildEnv {
        name = "qemu-ovmf";
        paths = config.virtualisation.libvirtd.qemu.ovmf.packages;
      };
      dirName = "libvirt";
    in
      mkAfter ''
        ln -s --force ${ovmfpackage}/FV/OVMF_CODE.ms.fd /run/${dirName}/nix-ovmf/
        ln -s --force ${ovmfpackage}/FV/OVMF_VARS.ms.fd /run/${dirName}/nix-ovmf/
      '';

    programs.virt-manager.enable = cfg.interface.graphical;
  };
}
