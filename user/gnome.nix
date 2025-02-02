# User-level GNOME configuration
{...}: {
  home-manager.users.sebastian = {
    dconf.enable = true;
    dconf.settings = {
      # Set dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # GNOME "Amber" wallpaper
      "org/gnome/desktop/background".picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      "org/gnome/desktop/background".picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/amber-d.jxl";
      "org/gnome/desktop/background".primary-color = "#ff7800";
      "org/gnome/desktop/background".secondary-color = "#000000";

      # Disable "Welcome to GNOME" dialog
      "org/gnome/shell".welcome-dialog-last-shown-version = "999"; # A huge number represents a version that doesn't yet exist, effectively disabling the dialog

      # Shortcuts
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_resources/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_terminal/"
      ];

      # Shortcut: Open Resources
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_resources" = {
        name = "Open Resources";
        command = "resources";
        binding = "<Shift><Control>Escape";
      };
      # Shortcut: Open Terminal
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_terminal" = {
        name = "Open Terminal";
        command = "blackbox";
        binding = "<Control><Alt>T";
      };
    };
  };
}
