{ self, nix-darwin, nixpkgs, home-manager, ... }:
let
  revision = { pkgs, ... }: {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
  };
in nix-darwin.lib.darwinSystem {
  modules = [
    ./configuration.nix
    revision
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.elliot = import ./home.nix;
    }
  ];
}

