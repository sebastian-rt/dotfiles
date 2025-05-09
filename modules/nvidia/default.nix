# Credit: https://github.com/TLATER/dotfiles/blob/0d1172a2add3e77c62b070d41b2c5caab09c6ab8/nixos-modules/nvidia/default.nix
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.easyNvidia;
in {
  imports = [
    ./vaapi.nix
  ];

  options.easyNvidia = with lib.types; {
    enable = lib.mkEnableOption "easyNvidia";
    withIntegratedGPU = lib.mkOption {
      type = bool;
      description = ''
        Whether the computer has a separate integrated GPU.

        This also configures the machine to use the integrated GPU for
        other things like software decoding, so keep this enabled even
        if you separately disable offload rendering.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.133.07";
        sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
        sha256_aarch64 = lib.fakeHash;
        openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
        settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
        persistencedSha256 = lib.fakeHash;
      };

      # This will no longer be necessary when
      # https://github.com/NixOS/nixpkgs/pull/326369 hits stable
      modesetting.enable = lib.mkDefault true;
      # Power management is nearly always required to get nvidia GPUs to
      # behave on suspend, due to firmware bugs.
      powerManagement.enable = true;
      # The open driver is recommended by nvidia now, see
      # https://download.nvidia.com/XFree86/Linux-x86_64/565.57.01/README/kernel_open.html
      open = true;

      dynamicBoost.enable = cfg.enable && cfg.withIntegratedGPU;
    };

    boot = {
      #kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod;

      extraModprobeConfig =
        "options nvidia "
        + lib.concatStringsSep " " [
          # nvidia assume that by default your CPU does not support PAT,
          # but this is effectively never the case in 2023
          "NVreg_UsePageAttributeTable=1"
          # This is sometimes needed for ddc/ci support, see
          # https://www.ddcutil.com/nvidia/
          #
          # Current monitor does not support it, but this is useful for
          # the future
          "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
        ];
    };

    environment.variables = {
      # Required to run the correct GBM backend for nvidia GPUs on wayland
      GBM_BACKEND = "nvidia-drm";
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # Hardware cursors are currently broken on wlroots
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
