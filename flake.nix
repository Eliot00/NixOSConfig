{
  description = "Elliot's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }@inputs:
  {
    nixosConfigurations.elliot-nixos = import ./hosts/amd-pc inputs;

    darwinConfigurations."ElliotdeMac-mini" = import ./hosts/mac-mini inputs;
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."ElliotdeMac-mini".pkgs;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
