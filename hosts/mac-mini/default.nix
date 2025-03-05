{ self, nix-darwin, nixpkgs, home-manager, rust-overlay, emacs-overlay, ... }:
let
  revision = { pkgs, ... }: {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
  };
in nix-darwin.lib.darwinSystem {
  modules = [
    ./configuration.nix
    ../../modules/substituters
    revision

    # Rust config
    ({ pkgs, ... }: {
      nixpkgs.overlays = [
        rust-overlay.overlays.default
        emacs-overlay.overlay
      ];
      environment.systemPackages = [
        (pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" ];
          targets = [
            "x86_64-linux-android"
            "aarch64-linux-android"
          ];
        })
      ];
    })

    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.elliot = import ./home.nix;
    }
  ];
}

