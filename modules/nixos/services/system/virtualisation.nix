{
  config,
  pkgs,
  ...
}: {
  boot.kernelParams = [
    "iommu=pt"
  ];

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
          })
          .fd
        ];
      };
    };
  };

  boot.kernelModules = [
    "vhost"
    "vhost_net"
    "vhost_iotlb"
  ];

  programs.virt-manager.enable = config.missos.system.interface.graphical;
}
