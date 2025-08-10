{inputs, ...}: let
  # Credit: https://github.com/sioodmy/dotfiles/blob/e107483729b29299687ffae03b7f066de7a2f5da/hosts/default.nix
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        # Dynamically set hostname and hostPlatform for all hosts
        {
          nix.settings.experimental-features = ["nix-command" "flakes"]; # Enable flakes for all hosts
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }

        {
          nixpkgs.overlays = [
            # Make unstable nixpkgs available under nixpkgs.unstable
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            })
          ];
        }

        # NUR module (adds nixpkgs overlay)
        inputs.nur.modules.nixos.default

        # Pre-built nix-index database + comma
        inputs.nix-index-database.nixosModules.nix-index
        {programs.nix-index-database.comma.enable = true;}

        inputs.disko.nixosModules.disko

        inputs.impermanence.nixosModules.impermanence

        # TODO: move?
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        # sops-nix
        inputs.sops-nix.nixosModules.sops
        ../modules/sops.nix

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
