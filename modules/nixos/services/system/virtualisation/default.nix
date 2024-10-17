{
  imports = [
    ./libvirtd.nix
  ];

  boot.kernelModules = [
    "vhost"
    "vhost_net"
    "vhost_iotlb"
  ];
}
