{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    android-studio
  ];

  environment.persistence."/persist/user".users.sebastian.directories = [
    ".android"
    "Android"
  ];
}
