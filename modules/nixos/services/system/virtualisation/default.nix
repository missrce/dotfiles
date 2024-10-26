{
  imports = [
    ./libvirtd.nix
    ./podman.nix
  ];

  boot.kernelModules = [
    "vhost"
    "vhost_net"
    "vhost_iotlb"
  ];
}
