{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    newsflash
  ];

  environment.persistence."/persist/user".users.${username}.directories = [
    ".config/newsflash"
    ".local/share/news-flash"
    ".local/share/news_flash"
  ];
}
