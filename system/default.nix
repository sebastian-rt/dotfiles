# This file contains common system-level configuration for all hosts
{
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = "24.11";

  # TODO: Move to separate file
  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [pkgs.xterm]; # Exclude xterm

  # Enable Wayland for Chromium/Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Exclude GNOME packages I don't need
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
    gnome-console
    snapshot
    gnome-music
    geary
    simple-scan
    totem
  ];

  security.polkit.enable = true;
  services.displayManager.sessionPackages = [pkgs.swayfx];
  home-manager.users.sebastian.wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx.override {
      # The home-manager module only applies extraOptions to the default sway package for some reason
      # Thus it only applies when not specifying a custom package
      # We can, however, override extraOptions manually:
      extraOptions = ["--unsupported-gpu"];
    };
    config = {
      output."*" = {
        background = "~/Pictures/amber-d.png fill";
      };
      startup = [
        {command = "wlsunset -l 49.4 -L 8.7 -t 2000";}
      ];
      keybindings = lib.mkOptionDefault {
        # Volume controls
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
    checkConfig = false; # Is this required?
    #extraOptions = ["--unsupported-gpu"]; # See above
    wrapperFeatures.gtk = true;
  };

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;

  # Some basic packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wlsunset
  ];
}
