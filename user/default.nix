# This file contains user-level configuration for my primary user (sebastian)
{
  pkgs,
  config,
  ...
}: let
  username = "sebastian";
in {
  imports =
    map
    (module: (import module {inherit username;})) # The username argument is passed on by the intermediate modules to the corresponding "hybrid" modules
    
    [
      ./programs
      ./packages.nix
      ./gnome.nix
      ./docker.nix
    ];

  users.users = {
    root.hashedPasswordFile = config.sops.secrets."user_passwords/root".path;
    ${username} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."user_passwords/${username}".path;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      description = "Sebastian";
      shell = pkgs.zsh; # zsh is installed in /system/default.nix
      openssh.authorizedKeys.keyFiles = [config.sops.secrets."user_ssh_keys/${username}".path];
    };
  };

  # Allows bluetooth media controls to be used
  systemd.user.services.mpris-proxy = {
    description = "MPRIS proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.udev.extraRules = config.home-manager.users.${username}.programs.easyeffects.newDeviceUdevHook; # TODO: come up with a better solution for this

  home-manager.users.${username} = {
    imports = [
      ../modules/easyeffects
    ];
    programs.home-manager.enable = true;

    programs.easyeffects = {
      #enable = true;
      runAsService = true;
      presets.output = [
        ./programs/audio/easyeffects/presets/None.json
        (./programs/audio/easyeffects/presets + "/DT 770 Pro Balanced Bass.json")
      ];
      devicePresets = {
        "alsa_output.usb-Focusrite_Scarlett_Solo_USB_*" = "DT 770 Pro Balanced Bass";
      };
    };

    home.username = username;
    home.homeDirectory = "/home/${username}";

    home.stateVersion = "25.05";
  };
}
