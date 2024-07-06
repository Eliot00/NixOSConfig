{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs
  ];

  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    tdesktop
    kdePackages.neochat

    anki-bin
    mpv # anki dependent on it

    vlc
    kdePackages.kate

    yarn
    nodePackages.pnpm

    # test unstable wayland ime protocols
    weston

    qbittorrent
  ];
  programs.git = {
    enable = true;
    userName = "Elliot";
    userEmail = "hack00mind@gmail.com";
    signing = {
      signByDefault = true;
      key = "D66320252AADEFFC";
    };
    aliases = {
      co = "checkout";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
    };
    extraConfig = {
      safe = {
        directory = [
          "/etc/nixos"
        ];
      };
    };
  };
  programs.obs-studio.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fish.enable = true;
  programs.kitty = {
    enable = true;
    theme = "Everforest Light Soft";
    font = {
      name = "Cascadia Code NF";
      size = 18;
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
