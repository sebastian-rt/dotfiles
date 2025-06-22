{username}: {...}: {
  home-manager.users.${username}.programs.tmux = {
    enable = true;
    clock24 = true;
  };
}
