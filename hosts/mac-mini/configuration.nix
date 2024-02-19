{ pkgs, ... }:

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        python3
        pdm

        nodejs
        nodePackages.typescript
        nodePackages.pnpm
        nodePackages.pm2
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
        sandbox = true;
    };

    programs.fish = {
        enable = true;
        shellAliases = {
            gst = "git status";
            gd = "git diff";
            gdc = "git diff --cached";
            gl = "git pull";
            gp = "git push";
            gco = "git checkout";
            gcm = "git checkout master";
            gb = "git branch";
            gcl = "git config --list";
            gcp = "git cherry-pick";
            ga = "git add";
            gaa = "git add --all";
            gsta = "git stash";
            gstp = "git stash pop";
            gstd = "git stash drop";
            cf = "git-cf";
        };
        shellInit = ''
            for p in /run/current-system/sw/bin
              if not contains $p $fish_user_paths
                set -g fish_user_paths $p $fish_user_paths
              end
            end
        '';
    };

    programs.zsh.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
}
