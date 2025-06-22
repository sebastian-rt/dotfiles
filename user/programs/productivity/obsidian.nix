{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    obsidian
  ];
}
# TODO: impermanence config

