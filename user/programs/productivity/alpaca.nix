{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = [
    pkgs.alpaca
  ];

  environment.persistence."/persist".users.sebastian.directories = [".local/share/com.jeffser.Alpaca"];
}
