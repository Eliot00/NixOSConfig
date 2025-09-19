{ nixpkgs, rust-overlay, ... }:
nixpkgs.lib.nixosSystem {
  system = "aarch64-linux";
  modules = [
    ./configuration.nix
    ../../modules/substituters

    # Rust config
    ({ pkgs, ... }: {
      nixpkgs.overlays = [
        rust-overlay.overlays.default
      ];
      environment.systemPackages = [
        pkgs.rust-bin.stable.latest.default
      ];
    })
  ];
}
