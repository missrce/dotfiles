{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce;
in {
  security = {
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
    "iommu=force"
    "randomize_kstack_offset=1"
  ];

  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = 3;
    "kernel.yama.ptrace_scope" = 3;

    "net.core.bpf_jit_harden" = 2;

    "dev.tty.ldisc_autoload" = 0;
    "dev.tty.legacy_tiocsti" = 0;

    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "fs.suid_dumpable" = 2;
  };
}
