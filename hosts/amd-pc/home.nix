{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs
  ];

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    tdesktop

    anki
    mpv # anki dependent on it

    vlc
    kdePackages.kate

    rust-analyzer
    typescript-language-server

    yarn
    nodePackages.pnpm

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
  programs.nushell = {
    enable = true;
    shellAliases = import ../../snips/alias.nix;
  };
  programs.starship = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    themeFile = "everforest_light_soft";
    font = {
      name = "Cascadia Code NF";
      size = 18;
    };
    keybindings = {
      "alt+t" = "new_tab_with_cwd";
      "alt+enter" = "new_window_with_cwd";
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";
    };
  };
}
