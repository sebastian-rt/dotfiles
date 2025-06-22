{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./tmux.nix
    ./zsh.nix
  ];
}
