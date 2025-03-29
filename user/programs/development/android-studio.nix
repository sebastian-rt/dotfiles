{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    android-studio
  ];

  environment.persistence."/persist".users.sebastian.directories = [
    ".android"
    "Android"
  ];
}
