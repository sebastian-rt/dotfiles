{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    blender
  ];
}
# TODO: impermanence config

