# This file contains common system-level configuration for all hosts
{pkgs, ...}: {
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
  ];
}
