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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }@inputs:
  {
    nixosConfigurations.elliot-nixos = import ./hosts/amd-pc inputs;
    nixosConfigurations.raspberry = import ./hosts/raspberry inputs;

    darwinConfigurations."ElliotdeMac-mini" = import ./hosts/mac-mini inputs;
    darwinConfigurations."Sariputra" = import ./hosts/sariputra inputs;
    darwinConfigurations."ElliotnoMacBook-Pro" = import ./hosts/mac-book inputs;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
