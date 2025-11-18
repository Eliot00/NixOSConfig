{ self, nix-darwin, nixpkgs, ... }:
let
  configuration = { pkgs, ... }: {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
      bun
      commit-formatter
      htop
      nodejs
      pnpm
      python3
      ripgrep
      starship
      typescript-language-server
      vim-darwin
      rsync
      gitui
    ];

    environment.variables = {
      EDITOR = "vim";
    };

    fonts.packages = [
      pkgs.maple-mono.NF
      pkgs.lxgw-wenkai-tc
      pkgs.nerd-fonts.iosevka
    ];

    nix.enable = false;

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

