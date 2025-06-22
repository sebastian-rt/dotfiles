{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [bitwarden-cli];
  };

  environment.persistence."/persist/user".users.${username}.directories = [".config/Bitwarden\ CLI"];
}
