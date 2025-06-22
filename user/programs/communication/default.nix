{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./vesktop.nix
  ];
}
