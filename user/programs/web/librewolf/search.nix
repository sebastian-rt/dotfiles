{...}: {
  default = "Brave Search";
  privateDefault = "Brave Search";
  force = true;
  engines = {
    "Brave Search" = {
      urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
      definedAliases = ["@brave"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/9/9d/Brave_lion_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "YouTube" = {
      urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
      definedAliases = ["@youtube"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "NixOS Packages" = {
      urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
      definedAliases = ["@nixpkgs"];
      iconUpdateURL = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "NixOS Options" = {
      urls = [{template = "https://search.nixos.org/options?query={searchTerms}";}];
      definedAliases = ["@nixos"];
      iconUpdateURL = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Home Manager Options" = {
      urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
      definedAliases = ["@homemanager"];
      iconUpdateURL = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Arch Wiki" = {
      urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
      definedAliases = ["@archwiki"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Arch Packages" = {
      urls = [{template = "https://archlinux.org/packages/?q={searchTerms}";}];
      definedAliases = ["@archpkgs"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "AUR" = {
      urls = [{template = "https://aur.archlinux.org/packages/?K={searchTerms}";}];
      definedAliases = ["@aur"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Firefox Addons" = {
      urls = [{template = "https://addons.mozilla.org/firefox/search/?q={searchTerms}";}];
      definedAliases = ["@addons"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/a/a0/Firefox_logo%2C_2019.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "OpenStreetMap" = {
      urls = [{template = "https://www.openstreetmap.org/search?query={searchTerms}";}];
      definedAliases = ["@osm"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/b/b0/Openstreetmap_logo.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Google Maps" = {
      urls = [{template = "https://www.google.com/maps/search/{searchTerms}";}];
      definedAliases = ["@gmaps"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/a/aa/Google_Maps_icon_%282020%29.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Reddit" = {
      urls = [{template = "https://www.reddit.com/search/?q={searchTerms}";}];
      definedAliases = ["@reddit"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/en/b/bd/Reddit_Logo_Icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    "Wayback Machine" = {
      urls = [{template = "https://web.archive.org/web/*/{searchTerms}";}];
      definedAliases = ["@wayback"];
      iconUpdateURL = "https://upload.wikimedia.org/wikipedia/commons/8/84/Internet_Archive_logo_and_wordmark.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    Bing.metaData.hidden = true;
  };
  order = ["Brave Search" "YouTube" "NixOS Packages" "NixOS Options" "Home Manager Options" "Arch Wiki" "Arch Packages" "AUR" "Firefox Addons" "OpenStreetMap" "Google Maps" "Reddit" "Wayback Machine"];
}
