{username}: {...}: {
  programs.thunderbird = {
    enable = true;
  };

  environment.persistence."/persist/user".users.${username}.directories = [".thunderbird" ".cache/thunderbird"];
}
