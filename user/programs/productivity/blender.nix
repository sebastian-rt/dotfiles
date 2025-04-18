{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    blender
  ];
}
