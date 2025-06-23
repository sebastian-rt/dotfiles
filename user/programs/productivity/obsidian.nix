{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    obsidian
  ];

  environment.persistence."/persist/user".users.${username}.directories = [".config/obsidian"];
}
