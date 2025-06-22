{username}: {pkgs, ...}: {
  home-manager.users.${username}.home = {
    packages = with pkgs; [
      vesktop
    ];
  };
  environment.persistence."/persist/user".users.${username}.directories = [".config/vesktop"];
}
