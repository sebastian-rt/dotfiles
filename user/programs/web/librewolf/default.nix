{...}: {
  home-manager.users.sebastian.programs.librewolf = {
    enable = true;
    settings = {
      # These overwrite the librewolf defaults
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
    };
    profiles = {
      sebastian = {
        settings = import ./preferences.nix;
        search = import ./search.nix;
      };
    };
  };
}
