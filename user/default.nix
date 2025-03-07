# This file contains user-level configuration for my primary user (sebastian)
{pkgs, ...}: {
  imports = [
    ./programs
    ./packages.nix
    ./gnome.nix
    ./docker.nix
  ];

  users.users.root.hashedPasswordFile = "/persist/secrets/password_root";
  users.users.sebastian = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/password_sebastian";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    description = "Sebastian";
  };

  home-manager.users.sebastian = {
    programs.home-manager.enable = true;

    home.username = "sebastian";
    home.homeDirectory = "/home/sebastian";

    home.stateVersion = "24.11";
  };
}
