{pkgs, ...}: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [pkgs.xterm]; # Exclude xterm

  # Exclude GNOME packages I don't need
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
    gnome-console
    snapshot
    gnome-music
    geary
    simple-scan
    totem
  ];
}
