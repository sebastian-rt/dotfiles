{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    spotify-player
  ];

  environment.persistence."/persist/user".users.sebastian.directories = [".cache/spotify_player"];
}
