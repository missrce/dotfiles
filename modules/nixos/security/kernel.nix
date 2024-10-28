{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce;
in {
  # FIXME: Please later on review the things and see what breaks Wine and what doesn't
  # Dev note this broke this project https://github.com/rumester/rumester

  security = {
    lockKernelModules = mkForce false;
    protectKernelImage = mkForce false;
    unprivilegedUsernsClone = mkForce config.virtualisation.containers.enable;
    allowUserNamespaces = mkForce true;
    allowSimultaneousMultithreading = true; # "Disabling SMT means that only physical CPU cores will be usable at runtime, potentially at significant performance cost."
  };

  boot.kernelParams = [
    "spectre_v2=auto"
    "spectre_v2_user=auto"
    "spec_store_bypass_disable=atuo"
    "retbleed=auto"
    "mitigations=auto"
    "tsx=auto"
    "init_on_free=1"
    "iommu.strict=1"
    "randomize_kstack_offset=1"
  ];

  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = 3;

    "dev.tty.ldisc_autoload" = 0;
    "dev.tty.legacy_tiocsti" = 0;

    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "fs.suid_dumpable" = 2;

    # Hide kptrs even for processes with CAP_SYSLOG
    "kernel.kptr_restrict" = mkForce null;

    # Disable bpf() JIT (to eliminate spray attacks)
    "net.core.bpf_jit_enable" = mkForce null;

    # Disable ftrace debugging
    "kernel.ftrace_enabled" = mkForce null;

    # Enable strict reverse path filtering (that is, do not attempt to route
    # packets that "obviously" do not belong to the iface's network; dropped
    # packets are logged as martians).
    "net.ipv4.conf.all.log_martians" = mkForce null;
    "net.ipv4.conf.all.rp_filter" = mkForce null;
    "net.ipv4.conf.default.log_martians" = mkForce null;
    "net.ipv4.conf.default.rp_filter" = mkForce null;

    # Ignore broadcast ICMP (mitigate SMURF)
    "net.ipv4.icmp_echo_ignore_broadcasts" = mkForce null;

    # Ignore incoming ICMP redirects (note: default is needed to ensure that the
    # setting is applied to interfaces added after the sysctls are set)
    "net.ipv4.conf.all.accept_redirects" = mkForce null;
    "net.ipv4.conf.all.secure_redirects" = mkForce null;
    "net.ipv4.conf.default.accept_redirects" = mkForce null;
    "net.ipv4.conf.default.secure_redirects" = mkForce null;
    "net.ipv6.conf.all.accept_redirects" = mkForce null;
    "net.ipv6.conf.default.accept_redirects" = mkForce null;

    # Ignore outgoing ICMP redirects (this is ipv4 only)
    "net.ipv4.conf.all.send_redirects" = mkForce null;
    "net.ipv4.conf.default.send_redirects" = mkForce null;
  };
}
