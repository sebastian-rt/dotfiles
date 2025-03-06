{inputs, ...}: let
  inherit (inputs) nixpkgs nixpkgs-unstable impermanence home-manager;
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

        # Make unstable nixpkgs available under nixpkgs.unstable
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            })
          ];
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
