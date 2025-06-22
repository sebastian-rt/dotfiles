{username}: {...}: {
  imports = map (module: import module {inherit username;}) [
    ./android-studio.nix
    ./git.nix
    ./github-cli.nix
    ./vscode.nix
  ];
}
