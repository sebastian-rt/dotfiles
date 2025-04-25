# This file contains user-level configuration for my primary user (sebastian)
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./programs
    ./packages.nix
    ./gnome.nix
    ./docker.nix
  ];

  users.users.root.hashedPasswordFile = config.sops.secrets."user_passwords/root".path;
  users.users.sebastian = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."user_passwords/sebastian".path;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    description = "Sebastian";
    shell = pkgs.zsh; # zsh is installed in /system/default.nix
  };

  home-manager.users.sebastian = {
    programs.home-manager.enable = true;

    home.username = "sebastian";
    home.homeDirectory = "/home/sebastian";

    home.stateVersion = "24.11";
  };
}
