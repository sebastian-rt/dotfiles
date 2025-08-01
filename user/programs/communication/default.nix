{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./thunderbird.nix
    ./vesktop.nix
  ];
}
