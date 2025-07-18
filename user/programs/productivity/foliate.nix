{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    foliate
  ];

  environment.persistence."/persist/user".users.${username}.directories = [
    ".cache/com.github.johnfactotum.Foliate"
    ".local/share/com.github.johnfactotum.Foliate"
  ];
}
