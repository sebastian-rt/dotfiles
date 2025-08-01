{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./alpaca.nix
    ./anki.nix
    ./blender.nix
    ./chatgpt-cli.nix
    ./foliate.nix
    ./gimp.nix
    ./libreoffice.nix
    ./obsidian.nix
    ./remnote.nix
  ];
}
