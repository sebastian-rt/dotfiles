{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./amberol.nix
    ./spot.nix
    ./spotify_player.nix
  ];
}
