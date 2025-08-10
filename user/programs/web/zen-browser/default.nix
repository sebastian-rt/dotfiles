{username}: {
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.${username} = {
    imports = [inputs.zen-browser.homeModules.twilight];
    programs.zen-browser = {
      enable = true;
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
            languagetool
          ];
        };
      };
    };
  };

  environment.persistence."/persist/user".users.${username}.directories = [
    ".zen"
  ];
}
