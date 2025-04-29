{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    (libreoffice-fresh.override {
      # Remove MIME type from desktop files, otherwise LibreOffice would be the default for every file type it supports
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
