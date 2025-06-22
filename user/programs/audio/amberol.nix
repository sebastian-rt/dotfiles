{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      amberol
    ];

    dconf.settings = {
      "io/bassi/Amberol".background-play = false;
    };
  };
}
