{pkgs, ...}: {
  home-manager.users.sebastian.programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
    userSettings = {
      "window.titleBarStyle" = "custom"; # Use vscode window decorations
      "editor.formatOnSave" = true;
      "security.workspace.trust.enabled" = false;
    };
  };
}
