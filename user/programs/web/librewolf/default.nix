{username}: {pkgs, ...}: {
  home-manager.users.${username}.programs.librewolf = {
    enable = true;
    settings = {
      # These overwrite the librewolf defaults
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.cache" = false;
      "privacy.clearSiteData.cache" = false;
      "privacy.clearSiteData.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.sanitize.sanitizeOnShutdown" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
    };
    profiles = {
      ${username} = {
        settings = import ./preferences.nix;
        search = import ./search.nix;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          addy_io
          untrap-for-youtube
          tridactyl
          dictionary-german
        ];
      };
    };
  };
}
