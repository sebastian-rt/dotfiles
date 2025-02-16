# User-level GNOME configuration
{pkgs, ...}: {
  home-manager.users.sebastian = rec {
    dconf.enable = true;
    # GNOME Extension Packages
    home.packages = with pkgs.gnomeExtensions; [
      useless-gaps
    ];

    dconf.settings = {
      # Enable GNOME Extensions
      "org/gnome/shell".enabled-extensions = pkgs.lib.map (extension: extension.extensionUuid) home.packages;

      # Set dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # Enable minimize/maximize buttons on window titlebars
      "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";

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
