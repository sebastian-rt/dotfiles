{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./librewolf
  ];
}
