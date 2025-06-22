{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./bitwarden-cli.nix
    ./blackbox.nix
    ./resources.nix
    ./virt-manager.nix
    ./warp.nix
  ];
}
