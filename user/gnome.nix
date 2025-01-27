# User-level GNOME configuration
{...}: {
  home-manager.users.sebastian = {
    dconf.enable = true;
    dconf.settings = {
      # Set dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
