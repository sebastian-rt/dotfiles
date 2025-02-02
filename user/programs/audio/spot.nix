{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    spot
  ];

  environment.persistence."/persist".users.sebastian.directories = [".cache/spot"];
}
