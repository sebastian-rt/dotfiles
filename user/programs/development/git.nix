{pkgs, ...}: {
  home-manager.users.sebastian.programs.git = {
    enable = true;
    userName = "Sebastian Ritz";
    userEmail = "git@rtz.cx";
  };
}
