{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    remnote
  ];

  environment.persistence."/persist".users.sebastian.directories = ["remnote" ".config/RemNote"];
}
