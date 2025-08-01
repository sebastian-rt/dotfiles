{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    anki-bin
  ];

  environment.persistence."/persist/user".users.${username}.directories = [
    ".cache/Anki"
    ".local/share/Anki2"
  ];
}
