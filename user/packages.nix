{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    alejandra
    nixd
    hello
    ffmpeg-full
    yt-dlp
    wget
    gnome-solanum
    openssl
    android-tools
    htop
    wl-clipboard
    clapper
  ];
}
