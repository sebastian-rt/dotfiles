{pkgs, ...}: {
  home-manager.users.sebastian.home = {
    packages = with pkgs; [
      vesktop
    ];
  };
  environment.persistence."/persist/user".users.sebastian.directories = [".config/vesktop"];
}
