{ self, nix-darwin, nixpkgs, ... }:
let
  configuration = { pkgs, ... }: {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
      vim-darwin
      python3Full
      nodejs
      pnpm
      typescript-language-server
      bun
      starship
    ];

    environment.variables = {
      EDITOR = "vim";
    };

    homebrew = {
      enable = true;
      casks = [
        "wezterm@nightly"
      ];
    };

    fonts.packages = [
      pkgs.maple-mono.NF
      pkgs.lxgw-wenkai-tc
    ];

    # Necessary for using flakes on this system.
    nix.settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "elliot"
      ];
    };

    # Enable alternative shell support in nix-darwin.
    programs.fish = {
      enable = true;
      shellAbbrs = import ../../snips/alias.nix;
    };

    system.primaryUser = "elliot";

    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "x86_64-darwin";
  };
in nix-darwin.lib.darwinSystem {
  modules = [
    configuration
    ../../modules/substituters
  ];
}

