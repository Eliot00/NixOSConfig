{
  description = "Elliot's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, stable, home-manager, rust-overlay, ... }@inputs: {
    nixosConfigurations.elliot-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        # Rust config
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rust-overlay.overlay ];
          environment.systemPackages = [
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
            })
          ];
        })

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.elliot = import ./home.nix;

            extraSpecialArgs = {
              inherit stable;
            };
          };
        }
      ];
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
