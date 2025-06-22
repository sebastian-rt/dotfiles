{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    (gimp.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          sed -i '/^MimeType=/d' $out/share/applications/*.desktop
        '';
    }))
  ];
}
