# User-level GNOME configuration
{pkgs, ...}: {
  home-manager.users.sebastian = {lib, ...}: rec {
    dconf.enable = true;
    # GNOME Extension Packages
    home.packages = with pkgs.gnomeExtensions; [
      useless-gaps
      system-monitor
      clipboard-history
      window-list
    ];

    dconf.settings = {
      # Enable GNOME Extensions
      "org/gnome/shell".enabled-extensions = pkgs.lib.map (extension: extension.extensionUuid) home.packages;

      # Extension: system-monitor
      "org/gnome/shell/extensions/system-monitor".show-swap = false;

      # Extension: clipboard-history
      "org/gnome/shell/extensions/clipboard-history".window-width-percentage = 13;
      "org/gnome/shell/extensions/clipboard-history".paste-on-selection = false;

      # Set dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # Night Light
      "org/gnome/settings-daemon/plugins/color".night-light-enabled = true;
      "org/gnome/settings-daemon/plugins/color".night-light-schedule-from = 21.0;
      "org/gnome/settings-daemon/plugins/color".night-light-schedule-to = 6.0;
      "org/gnome/settings-daemon/plugins/color".night-light-temperature = lib.hm.gvariant.mkUint32 2000;

      # Enable minimize/maximize buttons on window titlebars
      "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";

      # GNOME "Amber" wallpaper
      "org/gnome/desktop/background".picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/amber-l.jxl";
      "org/gnome/desktop/background".picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/amber-d.jxl";
      "org/gnome/desktop/background".primary-color = "#ff7800";
      "org/gnome/desktop/background".secondary-color = "#000000";

      # Accent Color
      "org/gnome/desktop/interface".accent-color = "red";

      # Disable "Welcome to GNOME" dialog
      "org/gnome/shell".welcome-dialog-last-shown-version = "999"; # A huge number represents a version that doesn't yet exist, effectively disabling the dialog

      # Shortcuts
      "org/gnome/shell/keybindings".screenshot = ["<Super>Return"];
      "org/gnome/shell/keybindings".show-screenshot-ui = ["<Shift><Alt>s"];
      "org/gnome/shell/keybindings".screenshot-window = ["<Shift><Super>s"];

      # Custom Shortcuts
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_resources/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_warp/"
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
      # Shortcut: Open Warp
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_warp" = {
        name = "Open Warp";
        command = "warp";
        binding = "<Control><Alt>W";
      };
    };
  };
}
