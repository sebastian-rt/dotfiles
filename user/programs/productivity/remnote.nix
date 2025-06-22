{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    remnote
  ];

  environment.persistence."/persist/user".users.${username}.directories = ["remnote" ".config/RemNote"];
}
