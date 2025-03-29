{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    # Here we patch the spot package to fix a bug that prevents playlists without a user added image from showing up
    # See here: https://github.com/xou816/spot/pull/716
    (spot.overrideAttrs
      (oldAttrs: {
        version = "0.5.0-fix";

        patches = [
          (fetchpatch {
            url = "https://github.com/xou816/spot/commit/cd55228b282c4728368fa42fe2848ab8dfb8ee1a.patch";
            hash = "sha256-5F9InR8uh5e7bGhwGkw0pQZZ62GrapVIPpauz7lKPUM=";
          })
        ];
      }))
  ];

  environment.persistence."/persist".users.sebastian.directories = [".cache/spot"];
}
