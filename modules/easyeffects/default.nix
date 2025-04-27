{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.easyeffects;
in {
  options.programs.easyeffects = {
    enable = lib.mkEnableOption "easyeffects";

    shutdownOnClose = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable && !cfg.runAsService;
      description = ''
        Whether to shutdown EasyEffects when the window is closed.
      '';
    };

    runAsService = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to run EasyEffects as a systemd user service.
        This will run EasyEffects in the background on startup.
      '';
    };

    presets.input = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = ''
        A list of paths to EasyEffects input presets.
      '';
      example = ''
        [ ./input-desser.json ./input-microphone-hicut.json]
      '';
    };

    presets.output = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = ''
        A list of paths to EasyEffects output presets.
      '';
      example = ''
        [ ./equalizer.json ./headphones.json ]
      '';
    };

    devicePresets = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = ''
        A list of presets to load for each device.
        The keys are the device names, and the values are the preset names.
        Device names support wildcards.
      '';
    };

    newDeviceUdevHook = lib.mkOption {
      type = lib.types.str;
      default = ''
        ACTION=="add", SUBSYSTEM=="sound", TAG+="systemd" ENV{SYSTEMD_USER_WANTS}="easyeffects-register-autoload-presets@1.service"
        ACTION=="add", SUBSYSTEM=="bluetooth", TAG+="systemd" ENV{SYSTEMD_USER_WANTS}="easyeffects-register-autoload-presets@3.5.service"
      '';
      description = ''
        udev rules to automatically create autoload presets for new devices.
        To use this, place services.udev.extraRules = home-manager.users.<user>.newDeviceUdevHook; somewhere
        This is a workaround for the fact that home-manager modules cannot create udev rules.
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.easyeffects];

    dconf.settings."com/github/wwmm/easyeffects".shutdown-on-window-close = cfg.shutdownOnClose;

    home.file = lib.listToAttrs ((map (preset: {
          name = ".config/easyeffects/input/${builtins.baseNameOf preset}";
          value = {
            source = preset;
          };
        })
        cfg.presets.input)
      ++ (map (preset: {
          name = ".config/easyeffects/output/${builtins.baseNameOf preset}";
          value = {
            source = preset;
          };
        })
        cfg.presets.output));

    systemd.user.services = let
      autoloadService = {
        Unit = {
          Description = "EasyEffects register autoload presets";
          After = ["pipewire-pulse.service"];
          Requires = ["pipewire-pulse.service"];
        };
        Service = {
          Type = "oneshot";
          ExecStartPre = "${pkgs.coreutils}/bin/sleep %i"; # This is necessary when the service is started by udev
          ExecStart = ''${pkgs.bash}/bin/bash -c "${pkgs.pulseaudio}/bin/pactl list sinks | ${pkgs.python3}/bin/python ${./create-easyeffects-autoload-presets.py} '${lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}=${value}") cfg.devicePresets)}'"'';
          ExecStartPost = lib.mkIf cfg.runAsService "${pkgs.systemd}/bin/systemctl --user restart easyeffects.service";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    in {
      "easyeffects-register-autoload-presets@" = lib.mkIf ((lib.attrNames cfg.devicePresets) != []) autoloadService;
      "easyeffects-register-autoload-presets@1" = lib.mkIf ((lib.attrNames cfg.devicePresets) != []) autoloadService; # Make it start on login
      easyeffects = lib.mkIf cfg.runAsService {
        Unit = {
          Description = "EasyEffects";
        };
        Install = {
          WantedBy = ["default.target"];
        };
        Service = {
          ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
        };
      };
    };
  };
}
