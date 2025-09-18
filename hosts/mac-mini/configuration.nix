{ pkgs, ... }:

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        python3

        bun
        nodejs
        pnpm
        typescript-language-server
        yarn

        rust-analyzer

        vim-darwin
        rsync
    ];

    fonts.packages = [
      pkgs.cascadia-code
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
        trusted-users = [ "root" "elliot" ];
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
