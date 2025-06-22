{username}: {pkgs, ...}: {
  home-manager.users.${username}.home.packages = with pkgs; [
    (libreoffice-fresh.override {
      # Remove MIME type from desktop files, otherwise LibreOffice would be the default for every file type it supports
      # TODO: figure out another way of reliably preventing libreoffice from preventing MIME types
      # This is really not an ideal solution, as libreoffice has very long build times
      unwrapped = libreoffice-fresh-unwrapped.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            sed -i '/^MimeType=/d' $out/share/applications/*.desktop
          '';
      });
    })
  ];
}
