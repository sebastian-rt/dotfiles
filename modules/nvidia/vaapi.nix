# Credit: https://github.com/TLATER/dotfiles/blob/0d1172a2add3e77c62b070d41b2c5caab09c6ab8/nixos-modules/nvidia/vaapi.nix
{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.easyNvidia.vaapi;
in {
  options.easyNvidia.vaapi = with lib.types; {
    enable = lib.mkOption {
      type = bool;
      default = config.easyNvidia.enable && !config.easyNvidia.withIntegratedGPU;
      description = ''
        Whether to enable the NVIDIA vaapi driver.

        This allows using the NVIDIA GPU for decoding video streams
        instead of using software decoding on the CPU.

        This particularly makes sense for desktop computers without an
        iGPU, as on those software en/decoding will take a lot of
        processing power while the NVIDIA GPU's encoding capacity
        isn't doing anything, so this option is enabled by default
        there.

        However, on machines with an iGPU, the dGPU's en/decoding
        capabilities are often more limited than those of the iGPU,
        and require more power, so this is disabled there by default -
        it may still make sense from time to time, so feel free to
        experiment.

      '';
    };

    maxInstances = lib.mkOption {
      type = nullOr int;
      default = null;
      description = ''
        The maximum number of concurrent instances of the driver.

        Sometimes useful for graphics cards with little VRAM.
      '';
    };
  };

  # See https://github.com/elFarto/nvidia-vaapi-driver#configuration
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [pkgs.libva-utils];
      variables =
        {
          NVD_BACKEND = "direct";
          LIBVA_DRIVER_NAME = "nvidia";
          MOZ_DISABLE_RDD_SANDBOX = "1";
        }
        // lib.optionalAttrs (cfg.maxInstances != null) {NVD_MAX_INSTANCES = toString cfg.maxInstances;};
    };

    # Moved to user/programs/web/librewolf/preferences.nix
    # programs.firefox.preferences = lib.mkIf cfg.firefox.enable {
    #   "media.ffmpeg.vaapi.enabled" = true;
    #   "media.rdd-ffmpeg.enabled" = true;
    #   "media.av1.enabled" = cfg.firefox.av1Support;
    #   "gfx.x11-egl.force-enabled" = true;
    #   "widget.dmabuf.force-enabled" = true;
    # };
  };
}
