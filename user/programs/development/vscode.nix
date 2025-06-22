{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          ms-python.python
          github.copilot
          github.copilot-chat
          ms-vsliveshare.vsliveshare
          esbenp.prettier-vscode
          vscodevim.vim
        ];
        userSettings = {
          "telemetry.telemetryLevel" = "off";
          "window.titleBarStyle" = "custom"; # Use vscode window decorations
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
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
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
          # VSCode Vim
          "vim.handleKeys" = {
            "<C-p>" = false;
          };
          "vim.useSystemClipboard" = true;
        };
        keybindings = [
          {
            key = "ctrl+[IntlBackslash]";
            command = "workbench.action.focusActiveEditorGroup";
            when = "!editorFocus";
          }
          {
            key = "ctrl+[IntlBackslash]";
            command = "terminal.focus";
            when = "editorFocus";
          }
        ];
      };
    };

    home.file.".vscode/argv.json".text = ''
      {
        "enable-crash-reporter": false,
        "password-store": "gnome-libsecret", // Force gnome-keyring; Required for window managers other than GNOME
      }
    '';
  };

  environment.persistence."/persist/user".users.${username}.directories = [".config/Code"];
}
