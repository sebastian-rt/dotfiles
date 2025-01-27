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
    };
  };
}
