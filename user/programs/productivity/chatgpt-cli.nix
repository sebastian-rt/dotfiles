{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = [
    (pkgs.writeShellScriptBin "chatgpt" ''
      export OPENAI_API_KEY=$(< /run/secrets/OPENAI_API_KEY_CLI)
      exec ${pkgs.chatgpt-cli}/bin/chatgpt "$@"
    '')
  ];
}
