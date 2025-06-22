{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./alpaca.nix
    ./blender.nix
    ./chatgpt-cli.nix
    ./gimp.nix
    ./libreoffice.nix
    ./obsidian.nix
    ./remnote.nix
  ];
}
