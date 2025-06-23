{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (vim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall)
        + ''
          sed -i '/^MimeType=/d' $out/share/applications/*.desktop
        '';
    }))
    git
    wlsunset
    playerctl
    file
    ripgrep-all
  ];
}
