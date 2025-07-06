{
  default = "Brave Search";
  privateDefault = "Brave Search";
  force = true;
  engines = {
    brave = {
      urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
      definedAliases = ["@brave"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/9/9d/Brave_lion_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    youtube = {
      urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
      definedAliases = ["@youtube"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    github = {
      urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
      definedAliases = ["@github"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/c/c2/GitHub_Invertocat_Logo.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    grep = {
      urls = [{template = "https://grep.app/search?q={searchTerms}";}];
      definedAliases = ["@grep"];
      icon = "https://grep.app/apple-icon.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    nixpkgs = {
      urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
      definedAliases = ["@nixpkgs"];
      icon = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    nixos = {
      urls = [{template = "https://search.nixos.org/options?query={searchTerms}";}];
      definedAliases = ["@nixos"];
      icon = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    homemanager = {
      urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
      definedAliases = ["@homemanager"];
      icon = "https://nixos.org/logo/nixos-logo-only-hires.png";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    archwiki = {
      urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
      definedAliases = ["@archwiki"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    archpkgs = {
      urls = [{template = "https://archlinux.org/packages/?q={searchTerms}";}];
      definedAliases = ["@archpkgs"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    aur = {
      urls = [{template = "https://aur.archlinux.org/packages/?K={searchTerms}";}];
      definedAliases = ["@aur"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/1/13/Arch_Linux_%22Crystal%22_icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    ffaddons = {
      urls = [{template = "https://addons.mozilla.org/firefox/search/?q={searchTerms}";}];
      definedAliases = ["@addons"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/a/a0/Firefox_logo%2C_2019.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    openstreetmap = {
      urls = [{template = "https://www.openstreetmap.org/search?query={searchTerms}";}];
      definedAliases = ["@osm"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/b/b0/Openstreetmap_logo.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    googlemaps = {
      urls = [{template = "https://www.google.com/maps/search/{searchTerms}";}];
      definedAliases = ["@gmaps"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/a/aa/Google_Maps_icon_%282020%29.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    reddit = {
      urls = [{template = "https://www.reddit.com/search/?q={searchTerms}";}];
      definedAliases = ["@reddit"];
      icon = "https://upload.wikimedia.org/wikipedia/en/b/bd/Reddit_Logo_Icon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    waybackmachine = {
      urls = [{template = "https://web.archive.org/web/*/{searchTerms}";}];
      definedAliases = ["@wayback"];
      icon = "https://upload.wikimedia.org/wikipedia/commons/8/84/Internet_Archive_logo_and_wordmark.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    mdn = {
      urls = [{template = "https://developer.mozilla.org/en-US/search?q={searchTerms}";}];
      definedAliases = ["@mdn"];
      icon = "https://developer.mozilla.org/favicon.svg";
      updateInterval = 7 * 24 * 60 * 60 * 1000;
    };
    bing.metaData.hidden = true;
  };
  order = [
    "brave"
    "youtube"
    "github"
    "grep"
    "nixpkgs"
    "nixos"
    "homemanager"
    "archwiki"
    "archpkgs"
    "aur"
    "ffaddons"
    "openstreetmap"
    "googlemaps"
    "reddit"
    "waybackmachine"
    "mdn"
  ];
}
