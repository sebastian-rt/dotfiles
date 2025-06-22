{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./audio
    ./communication
    ./development
    ./productivity
    ./shell
    ./tools
    ./web
  ];
}
