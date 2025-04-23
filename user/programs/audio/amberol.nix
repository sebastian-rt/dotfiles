{pkgs, ...}: {
  home-manager.users.sebastian = {
    home.packages = with pkgs; [
      amberol
    ];

    dconf.settings = {
      "io/bassi/Amberol".background-play = false;
    };
  };
}
