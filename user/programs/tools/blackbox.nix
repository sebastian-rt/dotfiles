{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    blackbox-terminal
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "blackbox";
  };
}
