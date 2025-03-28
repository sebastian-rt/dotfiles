{pkgs, ...}: {
  home-manager.users.sebastian = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-python.python
        github.copilot
        github.copilot-chat
        ms-vsliveshare.vsliveshare
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

    home.file.".vscode/argv.json".text = ''
      {
        "enable-crash-reporter": false,
        "password-store": "gnome-libsecret", // Force gnome-keyring; Required for window managers other than GNOME
      }
    '';
  };

  environment.persistence."/persist".users.sebastian.directories = [".config/Code"];
}
