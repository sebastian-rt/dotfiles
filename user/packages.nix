{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    alejandra
    nixd
    hello
    libreoffice-fresh
    ffmpeg-full
    yt-dlp
    amberol
    gh
    wget
    gnome-solanum
    gimp
    android-studio
    openssl
    android-tools
  ];
}
