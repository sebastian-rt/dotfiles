{username}: {...}: {
  home-manager.users.${username}.programs.git = {
    enable = true;
    userName = "Sebastian Ritz";
    userEmail = "git@rtz.cx";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
