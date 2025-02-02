# This file contains common system-level configuration for all hosts
{pkgs, ...}: {
  system.stateVersion = "24.11";

  # TODO: Move to separate file
  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
