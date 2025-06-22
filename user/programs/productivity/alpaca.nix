{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = [
    pkgs.alpaca
  ];

  environment.persistence."/persist/user".users.${username}.directories = [".local/share/com.jeffser.Alpaca"];
}
