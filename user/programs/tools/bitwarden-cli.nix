{pkgs, ...}: {
  home-manager.users.sebastian = {
    home.packages = with pkgs; [bitwarden-cli];
  };

  environment.persistence."/persist/user".users.sebastian.directories = [".config/Bitwarden\ CLI"];
}
