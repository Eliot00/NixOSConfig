{ nixpkgs, home-manager, rust-overlay, emacs-overlay, ... }:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix

    # Rust config
    ({ pkgs, ... }: {
      nixpkgs.overlays = [
        rust-overlay.overlays.default
        emacs-overlay.overlay
      ];
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
      };
    }
  ];
}
