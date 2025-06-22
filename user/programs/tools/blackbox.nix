{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      (blackbox-terminal.override {
        sixelSupport = true;
      })
    ];

    dconf.settings."com/raggesilver/BlackBox" = {
      use-custom-command = true;
      custom-shell-command = "${pkgs.tmux}/bin/tmux";
      use-sixel = true;
    };
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };
}
