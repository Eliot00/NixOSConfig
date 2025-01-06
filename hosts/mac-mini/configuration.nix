{ pkgs, ... }:

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        devenv

        python3
        pdm

        bun
        nodejs
        pm2
        pnpm
        typescript
        typescript-language-server
        yarn

        rust-analyzer

        vim-darwin

        # ios/android development
        ruby
        cocoapods
        jdk
    ];

    users.users.elliot = {
        home = "/Users/elliot";
    };

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings = {
        experimental-features = "nix-command flakes";
        sandbox = false;
        substituters = [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
        trusted-users = [ "root" "elliot" ];
    };

    programs.fish = {
        enable = true;
        shellAliases = import ../../snips/alias.nix;
        shellInit = ''
            for p in /run/current-system/sw/bin
              if not contains $p $fish_user_paths
                set -g fish_user_paths $p $fish_user_paths
              end
            end
        '';
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
}
