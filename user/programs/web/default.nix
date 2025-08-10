{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./librewolf
    ./zen-browser
    ./newsflash.nix
  ];
}
