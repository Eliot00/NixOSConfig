{ pkgs, ... }:

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        bun
        cmake
        guile
        nodejs
        pnpm
        python3
        rsync
        rust-analyzer
        typescript-language-server
        (vim-darwin.overrideAttrs (oldAttrs: rec {
          version = "9.1.1999";
          src = fetchFromGitHub {
            owner = "vim";
            repo = "vim";
            rev = "v${version}";
            hash = "sha256-yRqdOmyX/wK+1IIrGiJWA953mlL9JJx69ODmM6BTyAY=";
          };
        }))
    ];

    fonts.packages = [
      pkgs.maple-mono.NF
      pkgs.lxgw-wenkai-tc
      pkgs.nerd-fonts.iosevka
    ];

    users.users.elliot = {
        home = "/Users/elliot";
    };

    # Necessary for using flakes on this system.
    nix.settings = {
        experimental-features = "nix-command flakes";
        sandbox = true;
        extra-trusted-users = [ "elliot" ];
    };

    programs.fish = {
        enable = true;
        shellAbbrs = import ../../snips/alias.nix;
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
}
