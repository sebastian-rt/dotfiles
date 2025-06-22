{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    android-studio
  ];

  environment.persistence."/persist/user".users.${username}.directories = [
    ".android"
    "Android"
  ];
}
