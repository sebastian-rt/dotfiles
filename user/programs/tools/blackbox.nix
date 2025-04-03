{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    (blackbox-terminal.override {
      sixelSupport = true;
    })
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };
}
