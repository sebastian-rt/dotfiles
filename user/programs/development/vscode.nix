{pkgs, ...}: {
  home-manager.users.sebastian.programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      github.copilot
      github.copilot-chat
    ];
    userSettings = {
        "telemetry.telemetryLevel" = "off";
      "window.titleBarStyle" = "custom"; # Use vscode window decorations
      "editor.formatOnSave" = true;
      "security.workspace.trust.enabled" = false;
      # Nix IDE Extension
      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = ["alejandra"];
          };
        };
      };
    };
  };

  environment.persistence."/persist".users.sebastian.directories = [".config/Code"];
}
