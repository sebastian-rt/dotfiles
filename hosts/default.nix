{
  nixpkgs,
  impermanence,
  home-manager,
  ...
}: let
  # Credit: https://github.com/sioodmy/dotfiles/blob/e107483729b29299687ffae03b7f066de7a2f5da/hosts/default.nix
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules = [
        # Dynamically set hostname and hostPlatform for all hosts
        {
          nix.settings.experimental-features = ["nix-command" "flakes"]; # Enable flakes for all hosts
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }

        impermanence.nixosModules.impermanence

        # TODO: move?
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        # Host specific configuration
        ./${name}

        # Common system-level configuration
        ../system

        # User-level configuration
        ../user
      ];
    };
in {
  nixstation = mkHost "nixstation" "x86_64-linux";
}
