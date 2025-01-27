# This file contains user-level configuration for my primary user (sebastian)
{pkgs, ...}: {
  users.users.root.hashedPasswordFile = "/persist/secrets/password_root";
  users.users.sebastian = {
    isNormalUser = true;
    hashedPasswordFile = "/persist/secrets/password_sebastian";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    #   packages = with pkgs; [
    #     tree
    #   ];
  };
}
